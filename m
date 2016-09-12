From: Orion Poplawski <orion@cora.nwra.com>
Subject: Re: alsactl segfault
Date: Mon, 12 Sep 2016 13:44:02 -0600
Message-ID: <6c1023b4-ba23-7115-343c-637db9455d89@cora.nwra.com>
References: <c48658b5-7fad-d0a0-c3bd-34d43ff07ad1@cora.nwra.com>
 <s5h4m5malza.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.nwra.com (mail.nwra.com [72.52.192.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E12526680E
 for <alsa-devel@alsa-project.org>; Mon, 12 Sep 2016 21:44:06 +0200 (CEST)
In-Reply-To: <s5h4m5malza.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/11/2016 02:18 AM, Takashi Iwai wrote:
> On Fri, 09 Sep 2016 23:33:04 +0200,
> Orion Poplawski wrote:
>>
>> There are reports of alsactl segfaulting:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1335431
>> https://bugzilla.redhat.com/show_bug.cgi?id=1283737

>> Any idea what might be causing this?  Any other debug info that would be
>> helpful?  It doesn't crash all the time.
> 
> The patch below should fix the issue.  Give it a try.
> 
> 
> Takashi

That looks promising.  I'll give it a try and report back.  May take a bit
though as I'm not sure how often it crashed before.  Thanks!


-- 
Orion Poplawski
Technical Manager                     303-415-9701 x222
NWRA, Boulder/CoRA Office             FAX: 303-415-9702
3380 Mitchell Lane                       orion@nwra.com
Boulder, CO 80301                   http://www.nwra.com
