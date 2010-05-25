From: "Varadarajan, Srikanth" <srikanth.varadarajan@intel.com>
Subject: MMAP in ALSA
Date: Mon, 24 May 2010 17:16:25 -0700
Message-ID: <BCF80163639E9F4296FC4B208F99BA47013899D48F@orsmsx504.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 275DF2473C
	for <alsa-devel@alsa-project.org>;
	Tue, 25 May 2010 02:16:28 +0200 (CEST)
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

Hi All,
I am new to the list and ALSA.

For the hardware I am working with, we expose it to ALSA as one card capable of playing one PCM stream.

If we have one application using the hardware through ALSA, other applications are unable to get access to it. So, we want to have PulseAudio on top and use the pulse virtual device to render audio through ALSA. Is this a recommended way of having multiple applications access one audio HW simultaneously? Is there any other way of handling multiple applications get access to the same hardware?

Also, why are mmap and munmap operations required in ALSA?
Right now, we do not have mmap and munmap operations exposed. Though the hardware constraints have "SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID" defined. Looks like, if we have to PulseAudio on top, mmap operations are required in ALSA.

If there is a close enough ALSA implementation in the current Linux kernel that I can lookup, please point me to that.

Any help/suggestions are welcome.

Thanks,
Srikanth
