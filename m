From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/5] ALSA: snd-usb: ignore mixer units of type
	UAC2_EXTENSION_UNIT_V2
Date: Wed, 13 Jul 2011 02:13:28 +0200
Message-ID: <1310516009-4387-4-git-send-email-zonque@gmail.com>
References: <1310516009-4387-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <stable-bounces@linux.kernel.org>
In-Reply-To: <1310516009-4387-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
To: alsa-devel@alsa-project.org
Cc: stable@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Failing with a hard error is unjustified. Simply ignore them for now
so the rest of the device can be used.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: Nicolai Krakowiak <nicolai.krakowiak@gmail.com>
Cc: stable@kernel.org
---
 sound/usb/mixer.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index c43dbea..7f7dde8 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1899,6 +1899,9 @@ static int parse_audio_unit(struct mixer_build *state, int unitid)
 			return parse_audio_extension_unit(state, unitid, p1);
 		else /* UAC_VERSION_2 */
 			return parse_audio_processing_unit(state, unitid, p1);
+	case UAC2_EXTENSION_UNIT_V2:
+		snd_printdd(KERN_WARNING "Ignoring UAC2_EXTENSION_UNIT\n");
+		return 0; /* FIXME - extension units are not implemented yet */
 	default:
 		snd_printk(KERN_ERR "usbaudio: unit %u: unexpected type 0x%02x\n", unitid, p1[2]);
 		return -EINVAL;
-- 
1.7.5.4

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
