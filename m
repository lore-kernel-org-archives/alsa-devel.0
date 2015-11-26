From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel SST and HP ElitePad 1000 G2
Date: Thu, 26 Nov 2015 11:15:47 -0600
Message-ID: <56573E43.6070804@linux.intel.com>
References: <6A230045C5A9854B97A1D40971AC8BE1023ACE6013@NTMBOX.central.cirsa.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601C@NTMBOX.central.cirsa.com>
 <565346A2.8060702@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601E@NTMBOX.central.cirsa.com>
 <56547FE6.6050204@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE6022@NTMBOX.central.cirsa.com>
 <5655C851.4020405@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE6029@NTMBOX.central.cirsa.com>
 <565734E5.1060406@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B5C72605EE
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 18:15:51 +0100 (CET)
In-Reply-To: <565734E5.1060406@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jorge Fernandez Monteagudo <jorgefm@cirsa.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 11/26/2015 10:35 AM, Pierre-Louis Bossart wrote:
> On 11/26/2015 01:43 AM, Jorge Fernandez Monteagudo wrote:
>> Hi,
>>
>> I've regenerated from clean state the 4.3.0 but still no sound. Attached
>> dmesg, lsmod and .config used.
>>
>> From dmesg I can see
>>
>> [    4.357803] intel_sst_acpi 80860F28:00: No matching machine driver found

Ironically I just came across the same problem on the Asus TOOTAF which uses 10EC5642 as the _HID, Asus T100TA used 10EC5640. This HID was listed in the codec driver but not in the sst_acpi table so no machine driver loaded. Sounds like we will fix two platforms at once..
