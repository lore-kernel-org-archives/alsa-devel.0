From: Stephen Warren <swarren@nvidia.com>
Subject: patch_nvhdmi.c's snd_hda_preset_nvhdmi[] formatting,
 entry naming, new entries
Date: Mon, 9 Aug 2010 11:47:26 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF02FD6DF644@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B5B3246B8
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Aug 2010 20:51:55 +0200 (CEST)
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

All,

I'm working on a patch to add some new codec IDs to patch_nvhdmi.c. I notice
that many lines in that table are wrapped to avoid long lines. Is there a hard
80 column limit for ALSA driver or kernel files? I'd find the table and diff
much easier to read if I could simply put each new entry on a single line,
but don't want to violate any hard-and-fast coding style rules...

Second, I wish to add entries for some GPUs that haven't yet been released.
For these, I'd like to make the codec names simply "GPU HDMI/DP", since I
can't expose naming for unreleased products. We'd like to get these entries
into the driver early so that they're available in distros before products
ship, so that the hardware "just works" out of the box. Indications so far
are that these devices will simply be standard Azalia codecs, and hence not
need any code/tables/quirks to operate correctly (i.e. they'll follow the
existing "MCP89" path).

Finally, the naming for existing discrete GPU entries (GT220/GT21x/GT240) is
a mixture of engineering GPU names and marketing names. I'd like to edit these
names to also be simply "GPU HDMI/DP" for consistency. Unfortunately, I'm not
allowed to submit engineering GPU names for any GPUs, and using marketing
names in these entries doesn't make sense, since there may be multiple
marketing names per codec ID, and the marketing names many change over time.

Does anyone have any problems with any of the above before I submit a proposed
patch?

Thanks.

-- 
nvpublic
