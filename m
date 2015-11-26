From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Intel SST and HP ElitePad 1000 G2
Date: Thu, 26 Nov 2015 10:35:49 -0600
Message-ID: <565734E5.1060406@linux.intel.com>
References: <6A230045C5A9854B97A1D40971AC8BE1023ACE6013@NTMBOX.central.cirsa.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601C@NTMBOX.central.cirsa.com>
 <565346A2.8060702@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE601E@NTMBOX.central.cirsa.com>
 <56547FE6.6050204@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE6022@NTMBOX.central.cirsa.com>
 <5655C851.4020405@linux.intel.com>
 <6A230045C5A9854B97A1D40971AC8BE1023ACE6029@NTMBOX.central.cirsa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D760126060A
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 17:35:51 +0100 (CET)
In-Reply-To: <6A230045C5A9854B97A1D40971AC8BE1023ACE6029@NTMBOX.central.cirsa.com>
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

On 11/26/2015 01:43 AM, Jorge Fernandez Monteagudo wrote:
> Hi,
> 
> I've regenerated from clean state the 4.3.0 but still no sound. Attached
> dmesg, lsmod and .config used.
> 
> From dmesg I can see
> 
> [    4.357803] intel_sst_acpi 80860F28:00: No matching machine driver found

It's probably that you didn't re-add the weird HID in the sst_acpi.c file as you did previously.
If you want to send me your patches (offlist) i can take a look and merge them
with my soon-to-be-submitted ones.

> I think this kernel branch it's not well suited for the i915 graphic driver. I get
> some kernel warning that I don't see in 4.2.5. The freeze I'm seeing it's
> related to the graphic driver not the audio.

4.3 works fine for me, and all this code can be back-ported to 4.2 if need be.
