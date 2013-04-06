From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 1/2] ALSA: add DSD formats
Date: Sat, 06 Apr 2013 20:53:52 +0300
Message-ID: <51606130.1080208@sonarnerd.net>
References: <1365248693-27867-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id D4332264FE8
 for <alsa-devel@alsa-project.org>; Sat,  6 Apr 2013 19:53:52 +0200 (CEST)
In-Reply-To: <1365248693-27867-1-git-send-email-zonque@gmail.com>
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

On 04/06/2013 02:44 PM, Daniel Mack wrote:
> +#define SNDRV_PCM_FMTBIT_DSD_DOP_U8	_SNDRV_PCM_FMTBIT(DSD_DOP_U8)
> +#define SNDRV_PCM_FMTBIT_DSD_DOP_U16	_SNDRV_PCM_FMTBIT(DSD_DOP_U16)

No, this is not good, DoP always has the 8-bit marker in the MSB and has 
to be either 24-bit or longer word. One byte marker and two bytes of 
payload, padded with one byte of zeros if payload is 32-bit dword.
