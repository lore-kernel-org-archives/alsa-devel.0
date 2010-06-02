From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: Re: [PATCH] Ensure codec patch files are checked for
 the correct codec ID
Date: Wed, 02 Jun 2010 18:40:15 +0200
Message-ID: <4C06896F.7040202@epost.diwic.se>
References: <4C06729B.6050201@epost.diwic.se>
	<AANLkTinCaQtPG81MkTA2zE0AnYn7fdKN-Q6VsYX9sUBB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp02.sth.basefarm.net (ch-smtp02.sth.basefarm.net
	[80.76.149.213])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BFF3103982
	for <alsa-devel@alsa-project.org>;
	Wed,  2 Jun 2010 18:41:07 +0200 (CEST)
In-Reply-To: <AANLkTinCaQtPG81MkTA2zE0AnYn7fdKN-Q6VsYX9sUBB@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2010-06-02 18:03, Daniel Chen wrote:
> On Wed, Jun 2, 2010 at 11:02 AM, David Henningsson
> <launchpad.web@epost.diwic.se> wrote:
>> This one just popped out when I read the source code - or is there a
>> reason for parsing vendorid and subid without caring about the result?
> 
> Technically it matters little if the codec vendor_id and subsystem_id
> have valid values, because you can override them anyway. Codec address
> is the vital one.

In the individual case, maybe. However, assuming codec vendor and
subsystem are correctly matched, a distro could make a long list of
Codec SSID to model mappings, write down that in the patch file format,
and supply that patch file. One could then add mappings as a minor
distro update without having to recompile the kernel.

// David
