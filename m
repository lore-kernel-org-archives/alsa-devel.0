From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [RFC][PATCH 00/13 v1] Enhancement for Dice driver
Date: Mon, 19 May 2014 10:46:36 +0200
Message-ID: <5379C4EC.1060702@metafoo.de>
References: <1400420198-24312-1-git-send-email-o-takashi@sakamocchi.jp>
 <20140519095816.21acbc71@kant> <5379C277.9090804@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-145.synserver.de (smtp-out-049.synserver.de
 [212.40.185.49])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E369260815
 for <alsa-devel@alsa-project.org>; Mon, 19 May 2014 10:46:37 +0200 (CEST)
In-Reply-To: <5379C277.9090804@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Jonathan Woithe <jwoithe@just42.net>, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, Stefan Richter <stefanr@s5r6.in-berlin.de>, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On 05/19/2014 10:36 AM, Takashi Sakamoto wrote:
> Hi Stefan,
>
> (May 19 2014 16:58), Stefan Richter wrote:
>> On May 18 Takashi Sakamoto wrote:
>>> Takashi Sakamoto (13):
>>>    dice: Rename structure and its members
>>>    dice: Move file to its own directory
>>>    dice: Split transaction functionality into a file
>>>    dice: Split stream functionality into a file
>>>    dice: Split PCM functionality into a file
>>>    dice: Split hwdep functionality into a file
>>>    dice: Split proc functionality into a file
>>>    dice: Add new functions for limitation of PCM parameters
>>>    dice: Change the way to start stream
>>>    dice: Add support for duplex streams with synchronization
>>>    dice: Support for non SYT-Match sampling clock source mode
>>>    dice: Add support for PCM capture
>>>    dice: Add support for MIDI capture/playback
>>
>> Patch 02/12 apparently didn't get through to the mailinglist.  It is this
>> one,
>> https://github.com/takaswie/sound/commit/ad9a912161a3b6d2e48d19e185b50d4619ea5a53
>>
>> right?
>
> Yes.
>
> This patch includes more lines than these mailing lists (alsa-devel and
> ffado-devel) allow. So it needs approval by administrator.
>
> Jonathan and Iwai-san, would you please approve this patch to be blasted?
>

For patches like that one it is useful to use the -M flag when calling git 
format-patch. It will detect renames and hence you do not end up with + and 
- lines for each line in the file.

- Lars
