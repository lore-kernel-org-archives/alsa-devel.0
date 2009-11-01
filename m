From: "Kp, Jeeja" <jeeja.kp@intel.com>
Subject: Re: question on snd_jack_report
Date: Sun, 1 Nov 2009 19:54:00 +0530
Message-ID: <DC9628ADC672424FAECF61709E90EDDE6A24807E@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 8303824348
	for <alsa-devel@alsa-project.org>; Sun,  1 Nov 2009 15:24:06 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown  <IMCEAMAILTO-broonie+40opensource+2Ewolfsonmicro+2Ecom@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


When I call snd_jack_report with the status of the jack, am monitoring the /dev/input/eventX (using event.c) for Userspace events when Headset is inserted and I don't see any events even when snd_jack_report() is called. Is there any specific configuration that is required (xorg.config)?

-----Original Message-----
From: Mark Brown [mailto:broonie@opensource.wolfsonmicro.com] 
Sent: Wednesday, October 21, 2009 6:49 PM
To: Harsha, Priya
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] question on snd_jack_report

On Wed, Oct 21, 2009 at 06:22:47PM +0530, Harsha, Priya wrote:

Please fix your MUA to wrap at 80 columns, I have once more reflowed
your text to fit.

> When I call snd_jack_report with the status of the jack, from the user
> user space which parameter should I check in the
> sys/class/input/input2 to know if the jack is present or not?

Assuming you're looking to check the presence of a device in the jack
(rather than the presence of the jack itself) then there's nothing in
sysfs, you read this information from the device node.  See evtest.c
(google should show up lots of copies) for sample code doing this.
