From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: add DSD formats
Date: Sat, 06 Apr 2013 19:59:59 +0200
Message-ID: <5160629F.50400@gmail.com>
References: <1365248693-27867-1-git-send-email-zonque@gmail.com>
 <51606130.1080208@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f48.google.com (mail-bk0-f48.google.com
 [209.85.214.48])
 by alsa0.perex.cz (Postfix) with ESMTP id EBAC2264FD1
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 19:59:52 +0200 (CEST)
Received: by mail-bk0-f48.google.com with SMTP id jf3so2557519bkc.35
 for <alsa-devel@alsa-project.org>; Sat, 06 Apr 2013 10:59:52 -0700 (PDT)
In-Reply-To: <51606130.1080208@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

On 06.04.2013 19:53, Jussi Laako wrote:
> On 04/06/2013 02:44 PM, Daniel Mack wrote:
>> +#define SNDRV_PCM_FMTBIT_DSD_DOP_U8	_SNDRV_PCM_FMTBIT(DSD_DOP_U8)
>> +#define SNDRV_PCM_FMTBIT_DSD_DOP_U16	_SNDRV_PCM_FMTBIT(DSD_DOP_U16)
> 
> No, this is not good, DoP always has the 8-bit marker in the MSB and has 
> to be either 24-bit or longer word. One byte marker and two bytes of 
> payload, padded with one byte of zeros if payload is 32-bit dword.
> 

Well, the idea was to denote the fact that transport goes in multiple of
8 or 16 bits, which can then be interpreted by the calculation of the
actual sample rate. But I'm fine with anything else. What name would you
pick, assuming that you're fine with the general approach?


Thanks,
Daniel
