From: David Stuart <dave@sipquest.com>
Subject: Re: Quick question
Date: 03 Jun 2003 13:58:08 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054663089.20856.56.camel@dave.sipquest.com>
References: <200306031312.h53DCVFs026163@in1.magma.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306031312.h53DCVFs026163@in1.magma.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2003-06-03 at 09:18, Paul Davis wrote:

> its also very unclear what you want help with. there is nothing
> particularly different about capture and playback on 2 devices
> compared to doing it on just 1.

Ah, I think you misunderstand me a little bit.. it's not that I am
trying to do anything different than usual, it's that I'm having trouble
with the basics. Specifically, the HOW-TOs that I have found all seem to
have a different way of writing and reading to/from the hardware buffer.
I have not, as of yet, been able to find a clear description of the core
concepts around writing and reading to the device. Also some recommend
one way, and then another HOWTO says not to do it that way.. it's all
rather confusing.

For instance, I'm really not sure what size my buffer needs to be, if
there is a difference between the "hardware buffer" and the buffer in my
program, How "periods" work into all this, what's the difference between
hw and plughw, etc. Also each of the examples seems to configure the
hardware differently, which I find also odd..

So to sum it up, the problem is not only that I'm new to ALSA, but that
I'm new to sound programming in general. Is there somewhere I can go to
learn the basics (at least enough to do capture and playback, beyond
that I'm not as interested)?


-- 
David Stuart, SIPQuest
phone: 254-8886 x234 web: http://www.sipquest.com/



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
