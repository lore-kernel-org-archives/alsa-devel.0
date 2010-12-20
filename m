From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/3] Re:  Internal Mic vs Int Mic
Date: Mon, 20 Dec 2010 14:55:15 +0100
Message-ID: <4D0F6043.1010506@canonical.com>
References: <4D0F1CDA.2090009@canonical.com> <s5hvd2ozk19.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 6CB97245CE
	for <alsa-devel@alsa-project.org>; Mon, 20 Dec 2010 14:55:19 +0100 (CET)
In-Reply-To: <s5hvd2ozk19.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2010-12-20 13:49, Takashi Iwai wrote:
> At Mon, 20 Dec 2010 10:07:38 +0100,
> David Henningsson wrote:
>>
>> To try to clean up a little in the Volume Control namespace, it seems
>> "Int Mic" and "Internal Mic" both mean the same thing. "Internal Mic"
>> seems to be the winning one as it is used in
>> hda_codec.c:hda_get_input_pin_label.
>>
>> So, would a patch that changes every "Int Mic" to "Internal Mic" be
>> appreciated and merged?
>
> Sounds reasonable.  Go ahead.

Ok. I also took the liberty of renaming "Ext Mic" and "External Mic" to 
just "Mic", which is the de-facto standard for external microphone jacks.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
