From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: issue  at 44.1 Khz capturing
Date: Mon, 10 Aug 2009 15:36:04 +0530
Message-ID: <98769532B4BB14429434178695419EAE5F937821@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 86BAD103851
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 12:08:04 +0200 (CEST)
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
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I am using arecord for capturing data. When I try to record at 8 or 48 KHz, it's perfectly fine. But when I try to record at 44.1 Khz, there are spikes in the recorded data for every buffer. When I tried to tap the data captured at the firmware/hardware end, it's smooth but the same data when is checked from the user space after being recorded, it has spikes. On further analysis, looks like for every buffer recorded there is either 1 sample recorded extra or 1 sample dropped. But when I printed out the values passed from the pointer function, they are exactly at the intervals of 5513 bytes.

Can anyone give me any clue as to what is going wrong? I am using indirect_* functions in the driver code. Is there any buffer size round off that is giving this error? Can I handle something in the driver to avoid this?

Thanks,
Harsha.
