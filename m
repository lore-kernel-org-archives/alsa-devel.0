From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Compressed audio support over HDMI
Date: Tue, 04 Nov 2014 18:34:00 -0600
Message-ID: <54597078.7010205@linux.intel.com>
References: <CAA6Ozd5tPCEgavx0Pdg2bi5WQTL=L9utmD=H6nHayTEXP6gCag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A26626064F
 for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2014 01:34:20 +0100 (CET)
In-Reply-To: <CAA6Ozd5tPCEgavx0Pdg2bi5WQTL=L9utmD=H6nHayTEXP6gCag@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: D K <dspgro@gmail.com>, alsa-devel@alsa-project.org
Cc: vinod.koul@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On 11/4/14, 3:40 PM, D K wrote:
> Hi,
>     I recently came across the compressed audio framework used with ALSA-SOC.
> Can the framework be used to send compressed audio to HDMI driver?.Like
> using tinycompress from usespace .
> thanks,

HDMI already supports IEC modes when you can send AC3, DTS, etc payloads 
without decoding. All you need to do is packetize the data in userspace 
and send the result over the HDMI PCM device (and set some control bits 
to help the receiver lock faster).
