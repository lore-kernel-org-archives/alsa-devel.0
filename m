From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH 0/7] TCO fixes for RME MADI/Raydat/AIO/AES cards
Date: Sun, 10 Mar 2013 00:37:20 +0100
Message-ID: <1362872247-29029-1-git-send-email-adi@drcomp.erfurt.thur.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi!

I've spent another day at IOSONO to work with them on QA patches
for the RME MADI series, especially the optional TCO module (LTC
synchronisation with video cameras).

Here are our results, all tested for an entire week in their lab.



Cheers

Adrian Knoth (7):
  ALSA: hdspm - Refactor sample rate acquisition
  ALSA: hdspm - Allow the TCO and SYNC-IN to be used in slave mode
  ALSA: hdspm - Provide ALSA control to disable 96K frames
  ALSA: hdspm - Remove duplicate code from ALSA controls
  ALSA: hdspm - Also check for TCO sync states
  ALSA: hdspm - Add ALSA controls to read the TCO LTC state
  ALSA: hdspm - Enable new TCO ALSA controls

 sound/pci/rme9652/hdspm.c |  379 ++++++++++++++++++++++++++++-----------------
 1 file changed, 237 insertions(+), 142 deletions(-)

-- 
1.7.10.4
