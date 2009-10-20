From: brunal2496 gmail <brunal2496@gmail.com>
Subject: Exemple of source code for capture without using
	callback
Date: Tue, 20 Oct 2009 16:49:28 +0200
Message-ID: <26289049-EACA-4DC6-A396-E2AF4EB6F2E9@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f225.google.com (mail-ew0-f225.google.com
	[209.85.219.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 69E26246EE
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Oct 2009 16:49:31 +0200 (CEST)
Received: by ewy25 with SMTP id 25so5634509ewy.45
	for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2009 07:49:31 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

Hi all,

it's my first time on this list and my knowledge about using poll()  
mutex and thread creation is a bit far away from now, so please, if  
this list is the wrong place for such a question, could you point me  
in the right direction?

Does anyone can point me a place to find a good exemple of source code  
for capturing sound with alsa without using callbacks?

I'm trying to interface a voice recognition software with the alsa  
drivers.

I have to get audio from alsa convert it and then send to the  
recognition engine.
I've read everywhere that using callback is a bad method to use the  
alsa drivers.

As the recognition software is a server, it needs to be synchronized  
with my application. And so my main() cannot loop on a endless loop  
with the snd_pcm_readi() function inside.

My first idea was to create a new thread and to let this thread  
running with a endless loop that do the snd_pcm_readi() and send the  
buffer to the recognition software.
But I 've read the existence of smd_pcm_poll_descriptors() function.  
For now I not shure was it is for and how to use it properly.

What do you think?

I'm sorry if my question is a real newbie question, but exemple online  
are only for playback not capture.

Many thanks for all your answers.

Bruno.
