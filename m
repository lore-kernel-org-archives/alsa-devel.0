From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Cherry trail and Nau 88l24 codec
Date: Wed, 7 Dec 2016 08:19:19 -0600
Message-ID: <ddbc8fcf-024d-fe34-ba9c-c580c521baa2@linux.intel.com>
References: <CAPoeEY_Tve2TAgBqY+MqPEUGnbadYHg9Z90DQ=YQumWebfW++A@mail.gmail.com>
 <62e35b1dac6b4000beb73d857f780f04@NTHCML01B.nuvoton.com>
 <CAPoeEY8=A949-cuVwfyov2GfpQc=hAjPsDG-suXmT_TDytOKBQ@mail.gmail.com>
 <30f62f0d-1e3e-0839-8d85-df9e209b5cf9@linux.intel.com>
 <CAPoeEY98GP9VCQLPKSL0sUo3TDcgxHf65wCbR=T95wyJz2Ai7Q@mail.gmail.com>
 <CAPoeEY_QV8inYz=rAf5sveTtB5636sNwGyy0Uf==mPWuq0DZPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BDEA266499
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2016 15:19:35 +0100 (CET)
In-Reply-To: <CAPoeEY_QV8inYz=rAf5sveTtB5636sNwGyy0Uf==mPWuq0DZPg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Joseph Wang <joequant@gmail.com>
Cc: KCHSU0@nuvoton.com, alsa-devel@alsa-project.org, CTLIN0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

On 12/7/16 3:21 AM, Joseph Wang wrote:
> Two new items:
>
> 1) The firmware time outs happen when I try to turn on all of the switches
> in alsa mixer and set the volumes and gains of everything to 100%,  It
> doesn't like that.
>
> 2) In pulseaudio, I'm only seeing the output device "Headphones".  Not sure
> where this is getting set.
>
> But it looks like things are working up until the mixer, and it's a matter
> of finding the right magic configurations for those.

Don't try random settings and 100% volume, you're going to lose your 
hearing or speakers, or both.

start from the mixer values used here for the dsp
https://github.com/plbossart/UCM/blob/master/bytcr-rt5640/HiFi

remove everything related to rt5640 and add the modes for each 
input/output supported by your codec, starting from low volume until you 
find a setting that seems fine.

you really want to copy paste this directory and rename as needed, and 
copy the files in /usr/share/alsa/ucm.
