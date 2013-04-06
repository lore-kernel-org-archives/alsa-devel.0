From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 1/2] ALSA: add DSD formats
Date: Sun, 07 Apr 2013 00:56:40 +0300
Message-ID: <51609A18.2040905@sonarnerd.net>
References: <1365248693-27867-1-git-send-email-zonque@gmail.com>
 <51606130.1080208@sonarnerd.net> <5160629F.50400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 49219265016
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 23:56:41 +0200 (CEST)
In-Reply-To: <5160629F.50400@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

On 04/06/2013 08:59 PM, Daniel Mack wrote:
> On 06.04.2013 19:53, Jussi Laako wrote:
>> On 04/06/2013 02:44 PM, Daniel Mack wrote:
>>> +#define SNDRV_PCM_FMTBIT_DSD_DOP_U8	_SNDRV_PCM_FMTBIT(DSD_DOP_U8)
>>> +#define SNDRV_PCM_FMTBIT_DSD_DOP_U16	_SNDRV_PCM_FMTBIT(DSD_DOP_U16)
>
> Well, the idea was to denote the fact that transport goes in multiple of
> 8 or 16 bits, which can then be interpreted by the calculation of the
> actual sample rate. But I'm fine with anything else. What name would you
> pick, assuming that you're fine with the general approach?

I would just leave out the DOP part and call it SNDRV_PCM_FMTBIT_DSD_U8 
(8 DSD samples per unit) and SDNRV_PCM_FMTBIT_DSD_U16 (16 DSD samples 
per unit). This way it is agnostic to the fact if driver actually 
implements DoP or something else when talking to the actual hardware. It 
assumes all the bits in the unit to be valid DSD samples without any DoP 
marker byte stuff. If driver implements DoP inside, it shouldn't be 
visible outside. If application implements DoP it will anyway pick a 
traditional PCM sample format for the purpose.

It could also  have SNDRV_PCM_FMTBIT_DSD_U32 which is suitable for 
PCI/PCIe and many USB cases. Helps on alignment requirements...

For example SNDRV_PCM_FMTBIT_DSD_U8 and ALSA sample rate of 352800 -> 
DSD sample rate of 2822400. Or SDNRV_PCM_FMTBIT_DSD_U16 and 176400 -> 
DSD sample rate of 2822400.


	- Jussi
