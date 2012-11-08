From: Jeffrey Barish <jeff_barish@earthlink.net>
Subject: Re: Ticks when playing to USB DAC at high sample rates
Date: Thu, 08 Nov 2012 11:54:20 -0700
Message-ID: <1427406.0H8zTTgyKy@quintet>
References: <3884466.olklcBH31l@quintet> <9872736.seOqKZ7sS2@quintet>
	<509A235A.7000004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <509A235A.7000004@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed 07 November 2012 10:01:14 Daniel Mack wrote:
> On 07.11.2012 00:54, Jeffrey Barish wrote:
> > I guess that snd_usb_pcm_prepare is called by the core usb system to
> > prepare the snd driver.  Anyway, snd_usb_pcm_prepare calls
> > configure_endpoint with a substream.  Then configure_endpoint calls
> > snd_usb_endpoint_set_params with the data endpoint that corresponds to
> > the substream.  snd_usb_endpoint_set_params calls data_ep_set_params with
> > the data ep and data_ep_set_params sets nurbs to 2 for the data endpoint.
> > 
> > snd_usb_endpoint_set_params has code to call sync_ep_set_params when the
> > endpoint is type sync.  sync_ep_set_params sets nurbs to 4 (why?). 
> > However, snd_usb_endpoint_set_params never invokes the call to
> > sync_ep_set_params because ep->type is always data.  Back up:
> > snd_usb_endpoint_set_params is called from configure_endpoint.  It is
> > called from an if block contingent on the substream's having a sync
> > endpoint.  It does.  However, the call to snd_usb_endpoint_set_params
> > passes subs->data_endpoint as the first argument, so
> > snd_usb_endpoint_set_params simply repeats the operations it performed as
> > a result of the previous invocation.  I presume that the first argument
> > to the second call to snd_usb_endpoint_set_params should be
> > subs->sync_endpoint.
> Eh. You clearly spotted a bug here. The rally interesting thing is that
> that it didn't bite us earlier, as it's in since 3.6.

Here's the diff.  I can't figure out how to submit a patch.

--- sound/usb/pcm.c.orig        2012-11-08 11:43:57.309732860 -0700
+++ sound/usb/pcm.c     2012-11-08 11:41:06.512420658 -0700
@@ -456,7 +456,7 @@ static int configure_endpoint(struct snd
                return ret;
 
        if (subs->sync_endpoint)
-               ret = snd_usb_endpoint_set_params(subs->data_endpoint,
+               ret = snd_usb_endpoint_set_params(subs->sync_endpoint,
                                                  subs->pcm_format,
                                                  subs->channels,
                                                  subs->period_bytes,

-- 
Jeffrey Barish

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_nov
