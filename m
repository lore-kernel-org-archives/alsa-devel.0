From: Manuel Jander <manuel.jander@mat.utfsm.cl>
Subject: Re: 3D accelration control interface
Date: Thu, 20 Nov 2003 16:41:11 -0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1069357271.1060.182.camel@localhost>
References: <1069348281.809.157.camel@localhost>
	 <1069352739.26640.88.camel@lotte.street-vision.com>
Reply-To: mjander@mat.utfsm.cl
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1069352739.26640.88.camel@lotte.street-vision.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Justin Cormack <justin@street-vision.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

> Is there any hardware with enough documentation to write a driver?

I guess, yes. AFAIK the ESS maestro3 HRTF engine is documented. 
For the aureal Vortex soundcards, there is no documentation at all, but
i have just finished to tranlate the entire 3D interface code
(disassembling the windows driver and tranlating into C). There are
probably still bugs inside, but from my previous experience of
translating the hardware EQ support, i guess there are rather few.
At this point i have the information needed (and source code) to load
HRTF, atmospheric filter and Interaural Time Difference (ITD) parameters
into the hardware. I just have no way to link that together with
something useable (user space library).

The real matter is the design of "something" to glue together ALSA and
OpenAL. There may be other alternatives to OpenAL, but since its source
is open, its the seems to be the best candidate.

I guess there maybe some hardware vendor related people on this list.
They may be interested too.

Best Regards

Manuel




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
