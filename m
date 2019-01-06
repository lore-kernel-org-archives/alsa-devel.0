From: russell.parker7@gmail.com
Subject: [PATCH ucm/conf: 0/5] Factor out rt5645 + rt5650
	shared UCM sequences
Date: Sat,  5 Jan 2019 19:47:10 -0800
Message-ID: <20190106034715.21045-1-russell.parker7@gmail.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

When I submitted a patch to create a UCM config for chtrt5650 it was
suggested that I also factor out command sequences that it shares with
chtrt5645. The following patchset introduces a new component directory
codecs/rt5645-common/ and refactors UCM profiles in:

- chtrt5645
- chtrt5645-mono-speaker-analog-mic
- chtrt5650
- ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN
- LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216

I compiled and tested playback with the rt5650 configs but I don't
have the devices to test the other configurations. Suggestions and feedback
are welcome, I'm not very familiar with UCM configuration so there may
definitely be better approaches for some of these changes.

- Russell
