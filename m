From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: Atom: update Thinkpad 10
 quirk
Date: Mon, 17 Apr 2017 11:03:22 -0500
Message-ID: <feb2da96-500e-9064-81e5-00d37f6062e4@linux.intel.com>
References: <20170417150408.20935-1-pierre-louis.bossart@linux.intel.com>
 <20170417150408.20935-2-pierre-louis.bossart@linux.intel.com>
 <20170417151257.GA983524@phare.normalesup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BD21266872
 for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2017 18:03:25 +0200 (CEST)
In-Reply-To: <20170417151257.GA983524@phare.normalesup.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas George <george@nsup.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org



On 04/17/2017 10:12 AM, Nicolas George wrote:
> L'octidi 28 germinal, an CCXXV, Pierre-Louis Bossart a =E9crit :
>> There are multiple skews of the same Lenovo audio hardware
>> based on the Realtek RT5670 codec.
>> Manufacturer: LENOVO
>> 	Product Name: 20359
>> 	Version: Lenovo Miix 2 10
> Interesting. Any chance that applies to the Miix 3-1030 too?
no idea, you'd have to look at dmesg/DSDT and check if the same =

rt5640/rt5670 BIOS confusion applies.
>
>> +	{
>> +		.callback =3D byt_thinkpad10_quirk_cb,
>> +		.matches =3D {
>> +			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> +			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo Miix 2 10"),
> I guess I should run dmidecode, get the kernel sources, make a similar
> change and test. Unfortunately, I will probably not have time to do that
> until at least the week-end.
DMI decode is only needed once you've confirmed the device can't work =

with the normal ACPI handling.
Please provide your findings on bugzilla (dmesg, DSDT, alsa-info.sh)
https://bugzilla.kernel.org/show_bug.cgi?id=3D96691

>
> Thanks.
>
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
