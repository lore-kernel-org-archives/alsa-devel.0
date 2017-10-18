From: "PaX Team" <pageexec@freemail.hu>
Subject: Re: [PATCH v2 2/2] ALSA: hda - Fix incorrect TLV
	callback check introduced during set_fs() removal
Date: Wed, 18 Oct 2017 23:42:03 +0200
Message-ID: <59E7CAAB.32577.5C9CA22@pageexec.freemail.hu>
References: <20171017103401.5556-1-tiwai@suse.de>,
 <20171017103401.5556-3-tiwai@suse.de>
Reply-To: pageexec@freemail.hu
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from r00tworld.com (r00tworld.com [212.85.137.150])
 by alsa0.perex.cz (Postfix) with ESMTP id 209C4267503
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 23:42:12 +0200 (CEST)
In-reply-to: <20171017103401.5556-3-tiwai@suse.de>
Content-description: Mail message body
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 17 Oct 2017 at 12:34, Takashi Iwai wrote:

> Fixes: 99b5c5bb9a54 ("ALSA: hda - Remove the use of set_fs()")
> Reported-by: PaX Team <pageexec@freemail.hu>

thanks, you can also add Tested-by: PaX Team <pageexec@freemail.hu>.
