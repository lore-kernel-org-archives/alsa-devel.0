From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: DMIX and capture stream
Date: Mon, 5 Jan 2004 18:28:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040105182815.3d7a09c3.mista.tapas@gmx.net>
References: <200401040507.i0457Qbv005994@dhin.linuxaudiosystems.com>
	<Pine.LNX.4.58.0401051020560.8705@tomservo.workpc.tds.net>
	<Pine.LNX.4.58.0401051725380.1862@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401051725380.1862@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: dmlloyd@tds.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 5 Jan 2004 17:28:33 +0100 (CET)
Jaroslav Kysela <perex@suse.cz> wrote:

> > That is exactly the problem!  DMIX is for playback.  DSNOOP is for 
> > capture.  Where is the module that is for both?  Why, oh why, did
> > they not simply make ONE MODULE in the first place??
> 
> Both are logically separate, because they're doing absolutely
> different things.

Hmm, but they are very closely related in that they "share" access to a
soundcard. In one case it is for playback and the other for capture.
They are yin and yang. one mixes, the other distributes..

To make life simpler for users i think there should be a way to combine
these two into one pcm device that has all the goodies in one..  point
the OSS emu to it and you are ready to use two OSS apps at once [which
is _not_ possible at the moment, if one of the OSS apps wants to capture
audio additionally to the playback]

> What's your problems? ALSA applications should offer you to set the 
> playback and capture devices independently. 

> If you bother with the OSS
> emulation, simply change the code in oss_dsp_open() -
> alsa-oss/alsa-oss.c. Perhaps, we can do it for you.

Sorry, i'm not sure i understood you here. Do you mean you want to
change the OSS emu to have it use different pcm devices for playback and
capture? This would make combining dmix/dsnoop into one plugin
unnessecary. If that was your message, then please, please, pretty
please, with whipped cream on top, do so.. And if you don't have the
time for it, maybe some pointers to us all would be useful so we can
burn our hands on it... I don't know though how this would be specified
via the .asoundrc. As far as i know it is not possible to use two slaves
for a pcm device..

I have a hw mixing soundcard, but i think this is very important for
ALSA.. Hangout one day in #alsa and you will agree..

Flo

P.S.: Actually i think this really is all about the oss emu, since like
you said, correctly written alsa apps should let you select different
pcm's for playback and capture.. But i wonder:  how many are correctly
written and are facts like this documented in some alsa-developer infos?

-- 
music: http://www.soundclick.com/bands/9/florianschmidt.htm




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
