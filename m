From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [RFC] TLV entry for linear volume
Date: Wed, 23 Aug 2006 16:07:02 +0100
Message-ID: <44EC6F16.6090807@superbug.co.uk>
References: <s5h8xlfzhhu.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5h8xlfzhhu.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> Hi,
>
> some codecs and dsp chips use linear volumes instead of logarithmic
> one.  The patch below adds a new TLV type for such a volume type.
> In alsa-lib, it's converted to dB on the fly.
>
> If no one has objection, I'll push it together with AC97-TLV and
> other similar patches after 1.0.12 release.
>
>
> Takashi
>   
I have not had time to look at the AC97-TLV, but if it works, I can't 
see why I would object.

I have never come across a sound card with linear volumes.
Could you identify a few of them, and also better explain the formula 
you are using for the conversion to dB gain.
*db_gain = (long)(100.0 * 20.0 *
                      log10((double)(volume - rec->min) /
                        (double)(max - min)));

So, 0 dB is when (volume - rec->min) / (max - min) == 1
So, for +6 dB gain, the volume will need to be higher than max?
Does this sound right? In that case, maybe "max" is not a good name for 
it because volume can be greater than max.

James




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
