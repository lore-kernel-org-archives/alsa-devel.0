From: "James Courtier-Dutton" <james.dutton@gmail.com>
Subject: Re: what is the differenct between the mixer simple
	control and control?
Date: Tue, 12 Dec 2006 09:50:51 +0000
Message-ID: <ad2655cb0612120150l20f66e83wbc03ecfef46c9ab6@mail.gmail.com>
References: <001701c71d91$29e119f0$9b01a8c0@LiYong>
	<ad2655cb0612120126vc228388i94440b66d1bbab19@mail.gmail.com>
	<001c01c71dd1$19e6e080$9b01a8c0@LiYong>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4901F21A
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2006 10:50:53 +0100 (MET)
Received: by wx-out-0506.google.com with SMTP id h31so1725768wxd
	for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2006 01:50:52 -0800 (PST)
In-Reply-To: <001c01c71dd1$19e6e080$9b01a8c0@LiYong>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: YongLi <sdliyong@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/12/06, YongLi <sdliyong@gmail.com> wrote:
>
> This tlv320aic23.c file is used for TI tlv32023 audio codec chip. I got this file from the below website and changed something:
> http://www.fluff.org/ben/linux-26/audio9/s3c2410-audio9-codec.patch
>
> However, I think the changed are not related to the mixer controls. If necessary, I can send the modified file through email.
>
>
That patch is incomplete.
All the #define statements are missing.
E,g. Where is TLV320AIC23_HPVOL_ZEROCROSS defined?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
