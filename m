From: sh_okada@d4.dion.ne.jp
Subject: Re: New alsa lowlevel driver for the SE-200PCI and
 SE-90PCI
Date: Wed, 10 Oct 2007 21:49:37 +0900
Message-ID: <D230641.3000.sh_okada@d4.dion.ne.jp>
References: <s5h4ph0th3d.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dsmtp3.dion.ne.jp (mail.dion.ne.jp [61.117.3.52])
	by alsa0.perex.cz (Postfix) with ESMTP id DAEEB103871
	for <alsa-devel@alsa-project.org>;
	Wed, 10 Oct 2007 14:50:21 +0200 (CEST)
Received: from d4.dion.ne.jp (Q103243.ppp.dion.ne.jp [61.204.103.243])
	by dsmtp3.dion.ne.jp (8.11.7p3+Sun/8.11.7/050303) with SMTP id
	l9ACoHb06950
	for <alsa-devel@alsa-project.org>; Wed, 10 Oct 2007 21:50:17 +0900 (JST)
In-reply-to: Your message of "Tue, 09 Oct 2007 17:58:46 JST."
	<s5h4ph0th3d.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, sh_okada@d4.dion.ne.jp
List-Id: alsa-devel@alsa-project.org

>You can simply paste the patch in a mail.
>Some MUA cannot pass the text as is, and it would break the embedded
>patch.  In such a case, use an attachment.

Sorry, my MUA lost the CC field,
so the mail was not sent to the alsa-devel ML.

>Thanks, I took a look at it.  The code itself seems almost OK.
Thank you for the check. 

>But, before merging, please fix the coding style to follow the
>standard style.  Read $LINUX_KERNEL/Documentation/CodingStyle file
>first.  This describes many details.
>In doubt, run scripts/checkpatch.pl script included in the recent
>linux kernel tree.  It's a really picky guy, so you don't have to obey
>every detail :)

I want to rewrite, and to send it later. 

>Second, the mixer control names should follow standard names
>(somehow).  For example, in your code,
> {"Front(green) Playback Volume"	,WM8776output	,VOLUME1,0,NULL}
>,{"Surround(orange) Playback Volume"	,WM8766		,VOLUME1,1,NULL}
>,{"SurroundBack(white) Playback Volume"	,WM8766		,VOLUME1,2,NULL
>}
>,{"CenterAndSW(black) Playback Volume"	,WM8766		,VOLUME1,0,NULL}
>we have standard names: Front Playback Volume, Surround Playback
>Volume, Side Playback Volume, CLFE Playback Volume.  If Center and LFE
>can be split, it'd be much better to have two mono controls, Center
>Playback Volume and LFE Playback Volume.

And I want to rewrite as this.

But in Japan, How to call is different.
the speaker put the side of the seat position say SurroundSpeaker
and the speaker put the back say BackSpeaker.
When comparing it
Side <-> SurroundSpeaker
Surround <-> BackSpeaker
The twist phenomenon has occurred. 
What shall we do?

Though it is a proposal,
How about saying that the comment area will be added to the control name?
Like "Surround(orange) Playback Volume",
and When it is necessary to match the pattern,
the area of parentheses is deleted. 

Bool
new_check_same( char *req,char *src )
{
char buff_req[BUFSIZ];
char buff_src[BUFSIZ];

	strip_comment( buff_req,req );
	strip_comment( buff_src,src );

	return( check_same(buff_req,buff_src) );
}

Though it is a peculiar problem to this, SE-200PCI not has a notation of
the terminal, and the connection destination is shown only by the color.
It is not easy to understand.

So I want to write
"Side(orange,Surround) Playback Volume",
"Surround(white,SurrondBack) Playback Volume",


Thanks
