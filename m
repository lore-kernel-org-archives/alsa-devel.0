From: Paul Davis <pbd@op.net>
Subject: initial (incomplete) version of ALSA Audio API tutorial
Date: Thu, 21 Mar 2002 16:31:06 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203212131.g2LLV6b05497@op.net>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id WAA20649
	for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2002 22:31:23 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

prompted by phil kerr this morning, i started writing a tutorial on
using the ALSA Audio API (the term "PCM" is OK once you get into this
stuff, but ...). The following document represents it current state. I
would like to ask for feedback even though it is very incomplete. I
have not tested any of the programs yet. 

Specific things I would like feedback on:

	 * is this kind of document useful?
	 * are you totally put off by my low level discussion of
	     how an audio interface works?
         * are there design errors in the sample code?
	 * is my assumption that the default sw params settings
	     will work fine actually correct?
         * does the developer need to set period size?	     
	 * what material in particular do you want to see covered
	     by such a tutorial? it is not going to be 
	     a reference work, so keep that in mind. but i am
	     happy to extend it so that it describes (not documents)
	     all aspects of the ALSA Audio API.
         	     
One thing that has to change in the sample code is that there is
currently no error checking for any of the params setting calls. But I
would really appreciate it if Jaroslav and/or Abramo could review the
code and let me know if these examples are OK as simple cases. I also 
want to add more comments to the code to make it clear what they are
doing at each point.

I would appreciate it if anybody has any ideas on a really simple
way to get the playback examples to make a nice noise without
burdening the examples with either waveform generating code and/or
calls to some kind of audio file library.

Anyway, the URL:

	http://www.op.net/~pbd/alsa-audio.html

Let me know. This complaint about a lack of documentation for ALSA has
got to stop soon, and this is my contribution to making that happen
ASAP. My goal is to have a first, finished version of this ready by
the end of this weekend (march 24th).

--p
	

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
