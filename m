From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [alsa-devel] [PATCH] include/uapi/sound/firewire.h: use "_UAPI"
 instead of "UAPI"
Date: Thu, 07 Nov 2013 17:50:04 +0800
Message-ID: <527B624C.30500@asianux.com>
References: <527B0595.5030108@asianux.com> <527B4746.90009@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <527B4746.90009@ladisch.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11/07/2013 03:54 PM, Clemens Ladisch wrote:
> Chen Gang wrote:
>> > When installing, "scripts/headers_install.sh" will strip guard macro'
>> > "_UAPI" to prevent from appearing it to users. And also, all another
>> > files which need uapi prefix always use "_UAPI", not "UAPI".
>> >
>> > So use "_UAPI" instead of "UAPI" on the guard macro, and also give a
>> > comment for "#endif".
>> >
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Acked-by: Clemens Ladisch <clemens@ladisch.de>
> 

Thank you very much !!

-- 
Chen Gang
