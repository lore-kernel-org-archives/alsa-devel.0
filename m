From: "Eliot Blennerhassett" <bigblen@xtra.co.nz>
Subject: Writing a driver for this card: your thoughts?
Date: Thu, 6 Jun 2002 11:03:19 +1200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CFF4177.16823.43BD597@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-description: Mail message body
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Those of you who read linux-audio-dev will recognise the following. 
Thanks for your replies over there. 

It should have gone primarily to alsa-devel, but somehow didn't. 
========================== 

Hello, 

I work for AudioScience (www.audioscience.com) 

We make excellent (how could I say otherwise) audio cards. 

The emphasis within the company has been on microsoft windows drivers. 
... but we have a Linux driver, currently proprietary, closed source, that 
exposes this 
(http://www.audioscience.com/internet/download/spchpi.pdf) API. 

(It may be possible to release the host side code, but never the DSP code 
on the cards.) 

I think it would be much better if we had an ALSA driver. 

I'd like some idea how hard it would be to write an ALSA driver either as a 
compatibility layer on top of our existing driver, or from the ground up.  I 
realise that this is rather a broad question, so please consider this an 
invitation to enter discussion, rather than a request for you to go off and 
do a lot of work for me. 

Oh - what do you think of the cards' feature set?  


Some distinctive things about our cards (not all have all features) - they 
have on board DSP.  Code is downloaded by the driver. - they have a lot of 
on board buffer memory (hundreds of K at least) - on board DSP handles 
decompression/compression - mixing - samplerate conversion or multiple 
outputs at different rates - analog and digital audio I/O, balanced drivers 


=============================================
====
Eliot Blennerhassett                       *:-{)>
AudioScience, Inc. (New Zealand Office)
6 Centaurus Rd             
Christchurch 8002          Mobile: +64 21 1183531
New Zealand                Ph/fax: +64  3 3327818
eblennerhassett@audioscience.com
<http://www.audioscience.com>
=============================================
====


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
