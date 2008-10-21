From: "Mike Mazarick" <mazarick@bellsouth.net>
Subject: Re: Microphone array using ALSA
Date: Tue, 21 Oct 2008 07:37:42 -0400
Message-ID: <004901c93371$6e6fc6f0$4b4f54d0$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmailhost04.isp.att.net (fmailhost04.isp.att.net
	[204.127.217.104])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AEAA10381D
	for <Alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 13:38:03 +0200 (CEST)
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ola Benderious had written:

> Would it be possible to use several USB soundcards in GNU/Linux using 
> ALSA to build a microphone array? I have searched the Internet but 
> haven't found any straight answers. What I have read is that it might be 
> hard to sync the captured streams even if it would be possible.
>
> So, three questions.
> 1. Is it theoretically possible?
> 2. Can it be done using several USB soundcards?
> 3. Do you know of any code or project in this area as it is?

A friend of mine (Pete Mander) from England recently sent me the following
information on ambisonic mics.
I wrote:
> On another front, I'm planning on using my GadgetLabs cards to work with
Helmut Oellers creating a WaveFieldSynthesis system using 32 PC style
speakers in my house (they have the amps built in).   Since the GL cards
would only need to be outputs, I believe it may be possible to get 4 of them
to work in a linux system (however, that's to be tested).
http://www.syntheticwave.de
 
Pete replied:
I did ponder whether I could do ambisonic recordings with the GL. The
rigorously synchronised channels are perfect for this. I'll need to find
time and a child safe workshop to build the soundfield mic from condenser
capsules and the circuits:

http://www.ambisonia.com/wiki/index.php/Microphones#Home_made_tetrahedrons

Later on, Pete provided these additional fruits from his research:
http://parts.digikey.co.uk/1/1/27254-microphone-cartridge-9-7mm-x-5mm-wm-55a
103.html
http://homepage.ntlworld.com/henry01/cheap_soundfield/cheap_soundfield.htm
http://www.kokkinizita.net/linuxaudio/tetra-pict.html
http://en.wikipedia.org/wiki/Head-related_transfer_function

If you want to be cc'd on the correspondence between Pete, Helmut, and me,
send me a note off-line.

To answer your questions:
Q. Is it possible?   
A. Yes, but it doesn't quite make much sense to me unless there is some way
to play back what the mics record.

Q.  Can it be done with several USB soundcards?    
A.  The simple answer is no.
My opinion is that you'd want to sync the samples so they would not drift
apart.   
I don't know of an easy way to do this unless the soundcards are sync'd

Q. Do you know of any code or project in this area as it is?
No, I don't know of one.  In addition, it will be a month or two before we
even have a way to play back sources from multiple locations.
We are trying to play a few 'tricks' by positioning the speakers in a room
so that 32 channels sound like there are much more than 32 channels.

If you are going to play games with an array of mics in order to find the
position of a sound source, it seems that using multiple ambisonic mics is
the way to go.

Regards,

Mike Mazarick

(PS - if you had a slightly bigger budget, it would be quite possible to do
the same type of thing and set up a WFS system with the RME 96/52 cards)  
