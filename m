From: <twischer@de.adit-jv.com>
Subject: [PATCH - dmix v4 0/1] pcm: dmix: Align slave_hw_ptr to
	slave period
Date: Mon, 12 Nov 2018 13:47:17 +0100
Message-ID: <1542026838-13907-1-git-send-email-twischer@de.adit-jv.com>
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


Hi Takashi,

in the following we are providing the patch as requested by you:

On 11/6/18 17:32, Takashi Iwai wrote:
> I guess we may provide an option for choosing one of the following
> modes:
> 
> - current default mode;
>   no latency, but wakeup may be delayed, and may require 2*periods
> 
> - appl_ptr round up to the next period;
>   the current workaround for periods <= 2.
>   This imposes the start latency.
> 
> - round down to the current period start;
>   No latency, but will drop a few samples at start.
> 
> ... and ideally, provide a mode "auto" for choosing the appropriate
> one depending on the situation by a smart guess.

Please provide your feedback.

Best regards

Timo
