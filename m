From: Mark Goldstein <goldstein.mark@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Sat, 29 Jan 2011 12:42:25 +0200
Message-ID: <AANLkTikFtQpiAqfpgx-8BjJh=jcHwVW2OQccCU_23Yq7@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
	<AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
	<AANLkTinYcRqMwH2FSUjXiOxZg4x09q673FL9m15YvXEa@mail.gmail.com>
	<AANLkTik8HayTEADWn74PJ0NgjGunamsSAZpy_GanuZo3@mail.gmail.com>
	<AANLkTimz3iiXPhEarEUY1Gw5GxrTuv+UXgKKZS3ObzuS@mail.gmail.com>
	<AANLkTi=S20cpKy-CObvKB-OLDKbQ7FBhFrbnd448B+sO@mail.gmail.com>
	<AANLkTikyjZvD+ptCcgBrN2av-jQmKWOekbzvfXYAdpOV@mail.gmail.com>
	<AANLkTim_A5m2MryxmkEHtcc3gNFWTaRW8J3=dZC6wd67@mail.gmail.com>
	<AANLkTinUWD9Oq2iAbn_nc5E+M=y4yXx4u0Eff9jYSGyk@mail.gmail.com>
	<AANLkTimcAUn=+1B3=LJbD7dBBZ3NvaeX_q+_sHP6QhB3@mail.gmail.com>
	<AANLkTimiwTcnCnGECN8jpzY2VaMTmpcHBx-qmFDmwxSY@mail.gmail.com>
	<AANLkTi=14Q53BtcafboP=qz2-9AEcnnE3UD+HTwoGtbe@mail.gmail.com>
	<AANLkTimQ+evOVnG78UWPhCORKo2VvXyzVO8BhTrzSnVG@mail.gmail.com>
	<AANLkTim95ynONz5N27J4EOBR93ROsoWdZajovDCaWX9f@mail.gmail.com>
	<AANLkTinm3WYzzjVB-K6yVMeZm3+0hxsDGSb4+hQB4jLh@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 86AAD103803
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2011 11:42:47 +0100 (CET)
Received: by gxk21 with SMTP id 21so1654559gxk.38
	for <alsa-devel@alsa-project.org>; Sat, 29 Jan 2011 02:42:46 -0800 (PST)
In-Reply-To: <AANLkTinm3WYzzjVB-K6yVMeZm3+0hxsDGSb4+hQB4jLh@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Jan 29, 2011 at 11:37 AM, Mark Goldstein
<goldstein.mark@gmail.com> wrote:
> On Fri, Jan 28, 2011 at 2:47 AM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
>> 2011/1/27 Mark Goldstein <goldstein.mark@gmail.com>
>>
>>> On Thu, Jan 27, 2011 at 11:09 AM, Raymond Yau
>>> <superquad.vortex2@gmail.com> wrote:
>>> > 2011/1/27 Mark Goldstein <goldstein.mark@gmail.com>
>>> >

> Still trying to figure out why only Rear Mic works while Front Mic does not.

Ok, for some reason Pin-ctls for Front Mic (0x1e) set to VREF Hi-Z.
After I set it to VREF 50 using hda-analyser, Front Mic started
working. Have to figure out why it is set to Hi-Z.


-- 
Mark Goldstein
