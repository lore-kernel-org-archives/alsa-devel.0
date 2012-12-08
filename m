From: Ian Minett <ian_minett@creativelabs.com>
Subject: [PATCH 0/7] ALSA: CA0132: DSP Update
Date: Fri, 7 Dec 2012 21:35:56 -0800
Message-ID: <1354944963-4654-1-git-send-email-ian_minett@creativelabs.com>
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

Hi Takashi, thanks for the info about the endianness.
If the controller natively swaps each element as it gets read/written 
to the DSP then it sounds like it should work as is...

So with that in mind, we'd like to carry on with the DSP updates, if 
that's ok. The first batch is included in this patch series.

1: Add new definitions that will be used by the DSP routines
2: Add the new DSP mixer, switches and controls. This is quite large, but 
it's a little difficult to break it down further - hope it's ok.
3: Add code for handling data returned from the DSP.
4: Add support for tuning controls and data
5/6: Code tidy, split into two for a cleaner diff.
7: Updates to the mic sample rate, module description and memalloc error 
handling.

Thanks very much, please let us know if we need to alter anything.
- Ian

Signed-off-by: Ian Minett <ian_minett@creativelabs.com>
