From: <twischer@de.adit-jv.com>
Subject: [PATCH - dmix v5 0/1] pcm: dmix: Add option to allow
	alignment of slave pointers
Date: Tue, 13 Nov 2018 08:42:59 +0100
Message-ID: <1542094980-9389-1-git-send-email-twischer@de.adit-jv.com>
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


On 11/12/18 17:20, Takashi Iwai wrote:
> Please provide your own sign-off when you submitting a patch, too.
> 
> The subject line should be adjusted better to match with the change;
> it's about adding an option to allow alignment of hwptr reporting.
> 
> About the changes:
> the term "hw_ptr_filter" might sound confusing.  IMO, this is about
> the (hw)ptr alignment, not about filtering. 
> Also, a too long option string can easily lead to a misspell :)
> 
> After all, we do either "no" alignment, "roundup" or "rounddown", or
> "auto" choice.
> 
> 
> thanks,
> 
> Takashi

Subject changed.
Sign-off added.
Option changed to hw_ptr_alignment.
Option values changed to no, roundup, rounddown, auto

Best regards

Timo
