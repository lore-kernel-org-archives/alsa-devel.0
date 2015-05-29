From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [RFC][PATCH 0/2] ALSA: control: add dimen validator
Date: Fri, 29 May 2015 17:58:55 +0900
Message-ID: <1432889937-15413-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@alsa-project.org, perex@perex.cz
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset adds a validator for dimen field in control element
information.

The dimen information is used to represent channel matrix of the control
element, thus the number of elements in the matrix should be within the
number of channels in the control element.

Current implementation allows each drivers to set arbitrary number to
the information. When the information is wrong, it can cause
buffer-over-run to userspace applications depending on application
implementation.

Actually, the dimen information is scarcely used by current drivers and
applications, while it's better for ALSA core to ensure the information
is enough safe.

Takashi Sakamoto (2):
  ALSA: control: add dimension validator for userspace element
  ALSA: control: add dimension validator for kernel driver

 sound/core/control.c | 62 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 46 insertions(+), 16 deletions(-)

-- 
2.1.4
