From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: General protection fault when unloading
 snd_hda_intel on 2.6.30-rc1+
Date: Sat, 11 Apr 2009 13:20:33 -0700
Message-ID: <20090411132033.003c581c@infradead.org>
References: <20090411193630.GA16968@Pilar.aei.mpg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090411193630.GA16968@Pilar.aei.mpg.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, linux-kernel@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Apr 2009 21:36:30 +0200
"Carlos R. Mafra" <crmafra2@gmail.com> wrote:

> general protection fault:

Hi,

if you happen to have CONFIG_DEBUG_INFO enabled, then you can run the
oops through scripts/markup_oops.pl to get the source code of the exact
line that is oopsing.. makes diagnosing it even easier!



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
