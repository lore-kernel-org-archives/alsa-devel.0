From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: DMIX and capture stream
Date: Mon, 05 Jan 2004 12:41:12 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200401051741.i05HfCXl007120@dhin.linuxaudiosystems.com>
References: <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 05 Jan 2004 11:20:40 CST."
             <Pine.LNX.4.58.0401051113381.8705@tomservo.workpc.tds.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: David Lloyd <dmlloyd@tds.net>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Mailing List <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>I have application A that needs to open payback and capture streams 
>because it's a two-way communications program.  Application B is a game 
>that uses playback only.  I want to use these both at the same time.

but i don't think you can do this with OSS. why should ALSA's OSS
emulation make it possible? the OSS API doesn't support this. if they
used the ALSA API, it would work without (much) work on your part.

--p




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
