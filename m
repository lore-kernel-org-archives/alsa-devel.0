From: peloy@chapus.net (Eloy A. Paris)
Subject: Re: Occasional metallic sound when recording (cs46xx)
Date: Fri, 07 Nov 2003 18:19:19 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87d6c33gy0.fsf@canaima.chapus.net>
References: <200310221739.h9MHd0m1024945@oud.linuxaudiosystems.com>
	<3F981FF3.4040902@gmx.at> <87oew7g4m9.fsf@canaima.chapus.net>
	<s5h7k2u93l7.wl@alsa2.suse.de> <3FAAC709.8050509@cucumelo.org>
	<s5hllqsrtwl.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllqsrtwl.wl@alsa2.suse.de> (Takashi Iwai's message of "Fri,
 07 Nov 2003 18:05:30 +0100")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Benny Sjostrand <gorm@cucumelo.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Takashi Iwai <tiwai@suse.de> writes:

>> Your right this sympton may be specific for the cs46xx, I've
>> been experiencing this sympton with JACK and Ardour several
>> times.
>> 
>> The sample rate should not matter.  My guess is that internal buffers
>> occasionally get unsynchronized inside the DSP, may happen on
>> playback too.
>> 
>> The only I've found to get around the problem when it happens is to
>> restart the playback or capturing process.
>
> does changing ADC volume (or so, sorry, i forgot the detail) fix?
> IIRC, one post mentioned that.

Yes, when you start recording and get the darn metallic noise, if you
run alsamixer and toggle off and back on the capturing facility of the
ADC (hitting the space bar twice), sound comes back without the metallic
noise. There is no need to restart the playback or capturing process, at
least that's what I've found. Of course, this is less than ideal since
most of the times I am not around when my MythTV PVR starts to record a
show :-)

> anyway, it'd be helpful for debugging if someone can reproduce this
> certainly under a fixed condition...

Well, about 3 times out of 7 I get the problem, so it's not hard to
reproduce at all. What I'd have to know is where to place the debugging
printk()'s or something like that :(

Cheers,

Eloy.-


-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
