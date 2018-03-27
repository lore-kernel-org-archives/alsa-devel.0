From: Robert Rosengren <robert.rosengren@axis.com>
Subject: Re: [PATCH] ALSA: aloop: Mark paused device as inactive
Date: Tue, 27 Mar 2018 07:41:44 +0200
Message-ID: <a142f77d-cc4a-c934-574f-4b1e82ea54b8@axis.com>
References: <20180326052449.3618-1-robertr@axis.com>
 <s5hin9ilwx2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 11AFD266E4B
 for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2018 07:41:47 +0200 (CEST)
In-Reply-To: <s5hin9ilwx2.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 03/26/2018 04:43 PM, Takashi Iwai wrote:
> On Mon, 26 Mar 2018 07:24:49 +0200,
> Robert Rosengren wrote:
>>
>> Show paused ALSA aloop device as inactive, i.e. the control
>> "PCM Slave Active" set as false. Notification sent upon state change.
>>
>> This makes it possible for client capturing from aloop device to know if
>> data is expected. Without it the client expects data even if playback
>> is paused.
>>
>> Signed-off-by: Robert Rosengren <robertr@axis.com>
> 
> The code change looks good, but just to be sure:
> you've submitted from the address robert.rosengren@axis.com that is
> different from the sign-off robertr@axis.com.  Is this intentional?
> The former is recorded as the author in git history.
> 
> 
> thanks,
> 
> Takashi
> 

Sorry for the confusion. It is not intentional to use different though both are valid, apparently I have used the longer one in earlier patches to kernel so please change:
Signed-off-by: Robert Rosengren <robert.rosengren@axis.com>

Thanks for letting me know!
Robert
