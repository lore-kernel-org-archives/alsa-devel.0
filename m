From: Stephen Warren <swarren@nvidia.com>
Subject: Building Takashi's sound-2.6.git?
Date: Thu, 19 Aug 2010 15:04:03 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FE376611@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 989992442E
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 00:05:23 +0200 (CEST)
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
To: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'd like to use/develop-against/patch the ALSA drivers from:

git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git

... since I think they're the most up-to-date with patches?

However, that's a complete kernel tree rather than the subset that's
available in snapshots at:

ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/alsa/alsa-driver/

I figured I could just grab the above git, and also:

git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/alsa-driver-build.git

... to build just the ALSA driver modules. However, I can't see how to
get gitcompile from there to build the sound subset of a complete kernel
tree rather than e.g. something like:

http://git.alsa-project.org/?p=alsa-driver.git;a=summary

Can somebody give me a clue? Thanks very much.

(I guess I could just build the entire kernel, but that's a lot more time
than just the audio modules)

-- 
nvpublic
