From: Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH 2/2] Fix a stack buffer overflow bug in check_input_term
Date: Sun, 1 Sep 2019 15:00:28 +0200
Message-ID: <20190901130028.GB23334@eldamar.local>
References: <20190830214730.27842-1-benquike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190830214730.27842-1-benquike@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: stable@vger.kernel.org, Mathias Payer <mathias.payer@nebelwelt.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wenwen Wang <wang6495@umn.edu>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi Hui,

On Fri, Aug 30, 2019 at 05:47:29PM -0400, Hui Peng wrote:
> `check_input_term` recursively calls itself with input from
> device side (e.g., uac_input_terminal_descriptor.bCSourceID)
> as argument (id). In `check_input_term`, if `check_input_term`
> is called with the same `id` argument as the caller, it triggers
> endless recursive call, resulting kernel space stack overflow.
> 
> This patch fixes the bug by adding a bitmap to `struct mixer_build`
> to keep track of the checked ids and stop the execution if some id
> has been checked (similar to how parse_audio_unit handles unitid
> argument).
> 
> CVE: CVE-2018-15118

Similar to the previous one, this should be CVE-2019-15118 as far I
can tell.

Regards,
Salvatore
