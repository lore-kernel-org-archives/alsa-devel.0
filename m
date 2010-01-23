From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCHv2 1/6] ASoC: OMAP: data_type and sync_mode
 configurable in audio dma
Date: Sat, 23 Jan 2010 00:56:30 +0000
Message-ID: <1264208190.3480.39.camel@odin>
References: <2256F256009DAA4CBE661E9F41EAC84B8C43A8AD@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 34B89103805
	for <alsa-devel@alsa-project.org>; Sat, 23 Jan 2010 01:56:35 +0100 (CET)
Received: by ewy23 with SMTP id 23so2075687ewy.4
	for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2010 16:56:33 -0800 (PST)
In-Reply-To: <2256F256009DAA4CBE661E9F41EAC84B8C43A8AD@dlee01.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Candelaria Villareal, Jorge" <x0107209@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-01-22 at 17:14 -0600, Candelaria Villareal, Jorge wrote:
> From: Misael Lopez Cruz <x0052729@ti.com>
> 
> Allow client drivers to set the data_type (16, 32) and the
> sync_mode (element, packet, etc) of the audio dma transferences.
> 

Btw, how is 32bit mode used here ?

Is it for compacted 2 channel 16 bit stereo or 24bit HiFi on 4 byte
boundaries  ?

Liam
