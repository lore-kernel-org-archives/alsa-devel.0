From: <vanitha.channaiah@in.bosch.com>
Subject: [PATCH v2 0/6]
Date: Wed, 15 May 2019 11:56:31 +0530
Message-ID: <1557901597-19215-1-git-send-email-vanitha.channaiah@in.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: tiwai@suse.de, patch@alsa-project.org
Cc: twischer@de.adit-jv.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

- Updated the patches by incorporating review comments from Takashi Iwai-san

[PATCH 1/5] pcm: direct: Add generic hw_ptr_alignment function for dmix, dshare and dsnoop
[Takashi Iwai:]
> The patch description needs rephrasing.  What actually this does is to move the code from pcm_dmix.c to pcm_direct.c
> and its header so that the helper code can be re-used by other direct-PCM plugins.

- Commit message is rephrased as suggested.
- New commit: [PATCH v2 1/6] pcm: direct: Add generic hw_ptr_alignment function for


[PATCH 2/5] pcm: dshare: Added "hw_ptr_alignment"	option in configuration for alignment of slave pointers
[Takashi Iwai:]
> Again, this patch description is too ambiguous.
> And, if it enables the hw_ptr_alignment option, update the documentation as well.

- Commit message is explained in detail for the changes done.
- Documentation updated.
- New commit: [PATCH v2 2/6] pcm: dshare: Added "hw_ptr_alignment" option in


[PATCH 3/5] pcm: dsnoop: Added "hw_ptr_alignment"	option in configuration for slave pointer alignment
[Takashi Iwai:]
> Ditto as patch 2, the description is too ambiguous, and the update of documentation is missing.
> It's not good to change the helper function semantics out of sudden, even without any description.

- Commit message is explained in detail for the changes done.
- Documentation updated.
- Divided the patch with commit ("pcm: dsnoop: Add hw_ptr_alignment option in configuration")
  into additional patch commit ("pcm: direct: Round up of slave_app_ptr pointer if buffer")
- Usecase scenario is described for the changes done in helper function.
- New commit:
    [PATCH v2 3/6] pcm: dsnoop: Added "hw_ptr_alignment" option in
    [PATCH v2 4/6] pcm: direct: Round up of slave_app_ptr pointer if buffer


[PATCH 4/5] pcm: restructuring sw params function
[Takashi Iwai:]
> I see no reason to do that.  Please describe.

- Commit message is explained in detail why reformating was done.
- New commit: [PATCH v2 5/6] pcm: restructuring sw params function


[PATCH 5/5] pcm: Update pcm->avail_min with	needed_slave_avail_min, after reading unaligned frames
[Takashi Iwai:]
> This kind of changes in the core code should be avoided as much as possible, especially if it's only relevant with the specific plugins.
> Sorry, this isn't convincing enough.  If this is a MUST, please clarify better.

- Commit message is explained in detail with the generic usecase and specific use case we came across.
- New commit: [PATCH v2 6/6] pcm: Update pcm->avail_min with needed_slave_avail_min,
