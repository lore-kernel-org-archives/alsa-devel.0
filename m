From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/2] ALSA: echoaudio: add reference of struct
 echoaudio
Date: Mon, 03 Nov 2014 09:45:47 -0800
Message-ID: <1415036747.17743.24.camel@perches.com>
References: <1415010853-4334-1-git-send-email-sudipm.mukherjee@gmail.com>
	 <s5hwq7c1i7k.wl-tiwai@suse.de> <1415027288.17743.16.camel@perches.com>
	 <20141103165243.GA7562@sudip-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20141103165243.GA7562@sudip-PC>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2014-11-03 at 22:22 +0530, Sudip Mukherjee wrote:
> On Mon, Nov 03, 2014 at 07:08:08AM -0800, Joe Perches wrote:
[]
> > ftrace exists and is generic.
> > 
> > Several of these seem to be function tracing
> > style uses and should just be deleted instead.
> 
> function tracing style uses means?

ftrace

see:

Documentation/trace/ftrace.txt
Documentation/trace/ftrace-design.txt

> there are some prints which are printing the function name while printing the debug message.
> are those function tracing style uses??

A debug message should generally not be emitting a
message just for the sake of documenting when a
function is entered/left.

Sometimes that is useful for initial debugging, but
almost always those debugging printks should not be
left in the code that is pushed to kernel.org.
