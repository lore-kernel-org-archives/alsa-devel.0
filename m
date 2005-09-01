From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Problems or bugs in snd-usb-audio.ko
Date: Thu, 01 Sep 2005 11:28:56 -0400
Message-ID: <1125588537.19563.91.camel@mindpipe>
References: <200509011108.46288.luca_ing@libero.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200509011108.46288.luca_ing@libero.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Smery <luca_ing@libero.it>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-09-01 at 11:08 +0000, Smery wrote:
> > Lee Revell wrote:
> > > Because your device probably doesn'y support 8 bit mono at 8000Hz, which
> > > is the default format of arecord.
> >
> > As it happens, this is the only format supported by this device.
> > arecord would have complained if the format wasn't supported.
> 
> Yes, that's the only supported format.
> 

Pardon my ignorance but what's the point of a soundcard that only does 8
bit mono at 8000Hz?  VoIP?

Don't modern VoIP apps like Skype support better quality than that?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
