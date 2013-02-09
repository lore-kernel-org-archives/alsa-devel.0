From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 0/4] ALSA: Updates for the CA0132 codec
Date: Fri, 8 Feb 2013 18:31:41 -0800
Message-ID: <1360377105-2480-1-git-send-email-ian_minett@creativelabs.com>
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
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Ian Minett <ian_minett@creativelabs.com>
List-Id: alsa-devel@alsa-project.org

From: Ian Minett <ian_minett@creativelabs.com>

Hi,

This series contains the following updates to CA0132:

1: Add firmware loading for the SpeakerEQ DSP effect.
2: Improve DSP transfer timeout calculations.
3: Add stream and effect latency monitoring routines 
4: Update hp unsolicited event handler to manage queued work.

These were based on the latest sound.git, but please let me know if 
they should be against sound-unstable tree instead.

Thanks very much,
- Ian

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>
