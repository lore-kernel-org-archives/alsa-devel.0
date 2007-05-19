From: "Allyn, Mark A" <mark.a.allyn@intel.com>
Subject: Question on buffer size setting
Date: Fri, 18 May 2007 18:00:18 -0700
Message-ID: <5FD5754DDBA0B1499B5A0B4BB541948501183F8D@fmsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 317442443A
	for <alsa-devel@alsa-project.org>;
	Sat, 19 May 2007 03:00:40 +0200 (CEST)
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello:
 
I am attempting to do some debugging of a new audio device, and I need
to change the
number of buffer descriptor list entries from the default of 16 to
something much
smaller, like 3.

I am a bit confused while looking at the code. There seems to be a value
labeled
SNDRV_PCM_HW_PARAM_BUFFER_SIZE, but I can't figure how it is set. Is
this a parameter that
is passed as part of the configure prior to doing a make for the driver?
Is this a parameter
passed to modprobe when loading the driver? 

Thanks for your help.

Mark
