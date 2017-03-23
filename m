From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] ALSA: hda - Adding a group of pin
 definition to fix headset problem
Date: Thu, 23 Mar 2017 07:10:53 +0100
Message-ID: <20170323061053.GA21389@kroah.com>
References: <1490234425-32189-1-git-send-email-hui.wang@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 5985F2671D8
 for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2017 07:11:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1490234425-32189-1-git-send-email-hui.wang@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hui Wang <hui.wang@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, stable@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 23, 2017 at 10:00:25AM +0800, Hui Wang wrote:
> A new Dell laptop needs to apply ALC269_FIXUP_DELL1_MIC_NO_PRESENCE to
> fix the headset problem, and the pin definiton of this machine is not
> in the pin quirk table yet, now adding it to the table.
> 
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  sound/pci/hda/patch_realtek.c | 2 ++
>  1 file changed, 2 insertions(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read Documentation/stable_kernel_rules.txt
for how to do this properly.

</formletter>
