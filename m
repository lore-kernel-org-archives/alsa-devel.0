From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: get two mono channel from stereo line
Date: Fri, 24 Jul 2009 11:09:35 +0200
Message-ID: <4A697A4F.6000809@ladisch.de>
References: <c697747b0907232107k749c413bx2a88ccc97505447b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id A0F78103A6E
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jul 2009 11:09:21 +0200 (CEST)
In-Reply-To: <c697747b0907232107k749c413bx2a88ccc97505447b@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: arif setiawan <n.arif.setiawan@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

arif setiawan wrote:
> We have a beagleboard with one audio line-in and one audio line-out. From
> the documentation both are stereo line. Now we want to use four mono audio
> line for our system. two input from radio and microphone, two output to
> radio and speaker. We use ALSA and we would like to know how we can achieve
> this either by plugin or programming alsa.

Try something like this:

pcm_slave.stereo {
	pcm "hw:0,0"	# or whatever your device is
	channels 2
}

pcm.left {
	type asym
	playback.pcm {
		type plug
		slave.pcm {
			type dshare
			slave stereo
			ipc_key 200907241
			bindings [ 0 ]
		}
	}
	capture.pcm {
		type plug
		slave.pcm {
			type dsnoop
			slave stereo
			ipc_key 200907242
			bindings [ 0 ]
		}
	}
}

pcm.right {
	type asym
	playback.pcm {
		type plug
		slave.pcm {
			type dshare
			slave stereo
			ipc_key 20090724
			bindings [ 1 ]
		}
	}
	capture.pcm {
		type plug
		slave.pcm {
			type dsnoop
			slave stereo
			ipc_key 200907242
			bindings [ 1 ]
		}
	}
}


HTH
Clemens
