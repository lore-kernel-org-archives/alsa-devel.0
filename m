From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCHv2 0/9] ALSA: CA0132: DSP Update
Date: Thu, 20 Dec 2012 18:53:32 -0800
Message-ID: <1356058421-2683-1-git-send-email-ian_minett@creativelabs.com>
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

Thanks for the comments. This resubmit should help to correct many of the 
points raised.
For example, use of C99-style init for structures, the previous large patch
is now split into several subpatches, and there are more descriptions to 
the code and individual patchfiles.

Patch Summary:
1: Add new definitions and structures that will be used by the DSP routines
2: Init chip registers, DSP parameters and mixer settings
3: Add the new DSP mixer kcontrols and helpers.
4: Update and add PCM callbacks and enhancements.
5: Add unsol handler for DSP response and jack detection reporting
6: Add tuning controls
7/8: Code shuffle and tidy, split into two for a cleaner diff.
9: Updates to the mic sample rate and module description, and fix potential 
errors on init. 

Thanks,
- Ian

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>
