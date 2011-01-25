From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] azt3328: repair breakage (Re: [PATCH 1/1] SOUND: azt3328,
 fix broken AZF_FMT_XLATE macro)
Date: Tue, 25 Jan 2011 09:23:41 +0100
Message-ID: <4D3E888D.60909@suse.cz>
References: <1295704570-27015-1-git-send-email-jslaby@suse.cz> <s5h1v44j45c.wl%tiwai@suse.de> <20110125054631.GA10984@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110125054631.GA10984@rhlx01.hs-esslingen.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas Mohr <andi@lisas.de>
Cc: Takashi Iwai <tiwai@suse.de>, jirislaby@gmail.com, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>
List-Id: alsa-devel@alsa-project.org

On 01/25/2011 06:46 AM, Andreas Mohr wrote:
> It is also quite interesting to note that this rather uncommon language syntax
> (do...while(0) within switch scope) compiled cleanly without issue
> (no warnings).

Note that the switch block is the same like the others and case and
default and very similar to goto labels. You can even do:
switch (x) {
int abc;
{ case 5: abc = 7; break; }
do { case 3: abc = 5; break; } while (0);
while (1) {
        printf("%d\n", abc);
default:
        abc = 1;
}
}
And check what it will do for x == 3, 5, and others :).

regards,
-- 
js
suse labs
