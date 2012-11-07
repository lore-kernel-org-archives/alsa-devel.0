From: Jeffrey Barish <jeff_barish@earthlink.net>
Subject: Re: Ticks when playing to USB DAC at high sample rates
Date: Wed, 07 Nov 2012 10:05:12 -0700
Message-ID: <1604587.9oeL4nKNxL@quintet>
References: <3884466.olklcBH31l@quintet> <509A235A.7000004@gmail.com>
	<509A240E.2000802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <509A240E.2000802@gmail.com>
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

On Wed 07 November 2012 10:04:14 Daniel Mack wrote:
> On 07.11.2012 10:01, Daniel Mack wrote:
> > On 07.11.2012 00:54, Jeffrey Barish wrote:
> >> I guess that snd_usb_pcm_prepare is called by the core usb system to
> >> prepare the snd driver.  Anyway, snd_usb_pcm_prepare calls
> >> configure_endpoint with a substream.  Then configure_endpoint calls
> >> snd_usb_endpoint_set_params with the data endpoint that corresponds to
> >> the substream.  snd_usb_endpoint_set_params calls data_ep_set_params
> >> with the data ep and data_ep_set_params sets nurbs to 2 for the data
> >> endpoint.
> >> 
> >> snd_usb_endpoint_set_params has code to call sync_ep_set_params when the
> >> endpoint is type sync.  sync_ep_set_params sets nurbs to 4 (why?). 
> >> However, snd_usb_endpoint_set_params never invokes the call to
> >> sync_ep_set_params because ep->type is always data.  Back up:
> >> snd_usb_endpoint_set_params is called from configure_endpoint.  It is
> >> called from an if block contingent on the substream's having a sync
> >> endpoint.  It does.  However, the call to snd_usb_endpoint_set_params
> >> passes subs->data_endpoint as the first argument, so
> >> snd_usb_endpoint_set_params simply repeats the operations it performed
> >> as a result of the previous invocation.  I presume that the first
> >> argument to the second call to snd_usb_endpoint_set_params should be
> >> subs->sync_endpoint.> 
> > Eh. You clearly spotted a bug here. The rally interesting thing is that
> > that it didn't bite us earlier, as it's in since 3.6.
> > 
> >>  I
> >> 
> >> made that change.  Now freqm does change.  However, I am getting tons of
> >> ticks.  Now it sounds as if the payload size is always wrong.
> >> 
> >> Oh, 44.1 kHz works.  48 kHz works.  88.2 and 96 don't work.
> > 
> > That's a different issue. Would you like to prepare a patch for the
> > issue above please?

I don't know how to prepare a patch, so I'm inclined to fix the remaining 
problem before stopping to figure out the patch problem.

I didn't get your previous email.  I hope that it contained some suggestions 
on what to look for to solve the remaining problem.  Please send it again.  
The problem seems to be related to timing considering that the driver works 
perfectly 5-10% of the time, but timing of what?  I don't know what to look 
for.

> Thinking about it further, that could also explain the memory corruption
> we've revently seen in that driver ...
-- 
Jeffrey Barish

------------------------------------------------------------------------------
LogMeIn Central: Instant, anywhere, Remote PC access and management.
Stay in control, update software, and manage PCs from one command center
Diagnose problems and improve visibility into emerging IT issues
Automate, monitor and manage. Do more in less time with Central
http://p.sf.net/sfu/logmein12331_d2d
