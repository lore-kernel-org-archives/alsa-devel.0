From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK IO plug v2 0/3] snd_pcm_drain support
Date: Tue, 3 Jul 2018 15:59:20 +0200
Message-ID: <1530626363-8808-1-git-send-email-twischer@de.adit-jv.com>
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
To: patch@alsa-project.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Now in a clean manner as composed patches.


pcm: ioplug: Provide avail helper function
---------
No changes


jack: Avoid call to snd_pcm_avail_update() from JACK thread
---------
v2 uses snd_pcm_uframes_t as type for avail and does not check for avail < 0
becasue snd_pcm_ioplug_avail() will never retrun a value < 0


jack: Update poll_fd also in draining state
---------
This patch is depending on [1]. Therefore it was rebased on top of [1].
Additionally the commit message was extended.

v1 of this patch can be found in [2].

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-July/137775.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-July/137769.html
