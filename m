From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] include/uapi/sound/firewire.h: use "_UAPI"
 instead of "UAPI"
Date: Thu, 07 Nov 2013 17:49:42 +0800
Message-ID: <527B6236.9090908@asianux.com>
References: <527B0595.5030108@asianux.com> <s5hd2mcv9u5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 by alsa0.perex.cz (Postfix) with ESMTP id A6B932652F8
 for <alsa-devel@alsa-project.org>; Thu,  7 Nov 2013 10:47:35 +0100 (CET)
In-Reply-To: <s5hd2mcv9u5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "dhowells@redhat.com" <dhowells@redhat.com>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/07/2013 05:29 PM, Takashi Iwai wrote:
> At Thu, 07 Nov 2013 11:14:29 +0800,
> Chen Gang wrote:
>> > 
>> > When installing, "scripts/headers_install.sh" will strip guard macro'
>> > "_UAPI" to prevent from appearing it to users. And also, all another
>> > files which need uapi prefix always use "_UAPI", not "UAPI".
>> > 
>> > So use "_UAPI" instead of "UAPI" on the guard macro, and also give a
>> > comment for "#endif".
>> > 
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Thanks, applied.


Thank you very much !!

-- 
Chen Gang
