From: David Lloyd <dmlloyd@tds.net>
Subject: Re: DMIX and capture stream
Date: Tue, 6 Jan 2004 11:05:52 -0600 (CST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401061105040.8705@tomservo.workpc.tds.net>
References: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>
 <200401051741.i05HfCXl007120@dhin.linuxaudiosystems.com> <s5h1xqe2rjp.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xqe2rjp.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Jan 2004, Takashi Iwai wrote:

> anyway, it's possible if you use aoss wrapper and specify dmix/dsnoop as
> the device.  you're right for the kernel emulation.  no way. but still
> we need a fix for aoss wrapper.  the only necessary change is to allow
> aoss open different pcm per playback and capture stream.
>
> for example, the below is a minute quick hack (untested) for that. you
> can specify pcm.dsp0p and pcm.dsp0c for playback and capture directions,
> respectively.

This patch works great - I'm now able to use TeamSpeak (which opens 
capture and playback through oss) at the same time as xmms.

- D


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
