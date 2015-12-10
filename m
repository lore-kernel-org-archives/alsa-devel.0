From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: A root cause of "unable to create IPC shm instance"
Date: Thu, 10 Dec 2015 12:30:02 +0100
Message-ID: <5669623A.3070208@perex.cz>
References: <COL125-W23C67B4D2A800D0EEC9E51D2E90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id A9A93264FFB
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 12:30:02 +0100 (CET)
In-Reply-To: <COL125-W23C67B4D2A800D0EEC9E51D2E90@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: IceBsi <bsiice@msn.com>
List-Id: alsa-devel@alsa-project.org

Dne 10.12.2015 v 12:04 IceBsi napsal(a):
> Dear ALSA developers:
> 
> I found a root cause of the following issue by using strace:
>     unable to create IPC shm instance
> 
> Firstly, please see the test code below:
>   1 #include <stdio.h>
>   2 #include <unistd.h>
>   3 #include <sys/ipc.h>
>   4 #include <sys/shm.h>
>   5 #include <errno.h>
>   6 #include <string.h>
>   7 
>   8 int main(int argc, char *argv[])
>   9 {
>  10 	int r = 0;
>  11 	struct shmid_ds buf;
>  12 	key_t ipc_key = (key_t)325559;
>  13 	size_t shmsize = 488;
>  14 	int shmid = -1;
>  15 	mode_t ipc_perm = 0666;
>  16 	void *shmptr = NULL;
>  17 	pid_t pid;
>  18 
>  19 	printf("___%d:%d call shmget(%d,%u,%d)\n", __LINE__, getpid(), (int)(ipc_key), shmsize, IPC_CREAT | ipc_perm);
>  20 	shmid = shmget(ipc_key, shmsize, IPC_CREAT | ipc_perm);
>  21 	printf("___%d:%d ret shmget=%d\n", __LINE__, getpid(), shmid);
>  22 
>  23 	printf("___%d:%d call shmat(%d,0,0)\n", __LINE__, getpid(), shmid);
>  24 	shmptr = shmat(shmid, 0, 0);
>  25 	printf("___%d:%d ret shmat=%p\n", __LINE__, getpid(), shmptr);
>  26 
>  27 	printf("+++%d:%d call fork\n", __LINE__, getpid());
>  28 	pid = fork();
>  29 	printf("+++%d:%d ret fork=%d\n", __LINE__, getpid(), (int)pid);
>  30 
>  31 	printf("___%d:%d call shmctl(%d,IPC_STAT,%p)\n", __LINE__, getpid(), shmid, &buf);
>  32 	r = shmctl(shmid, IPC_STAT, &buf);
>  33 	printf("___%d:%d ret shmctl=%d\n", __LINE__, getpid(), r);
>  34 	printf("___%d:%d nattch=%lu\n", __LINE__, getpid(), buf.shm_nattch);
>  35 
>  36 	printf("___%d:%d call shmdt(%p)\n", __LINE__, getpid(), shmptr);
>  37 	r = shmdt(shmptr);
>  38 	printf("___%d:%d ret shmdt=%d\n", __LINE__, getpid(), r);
>  39 
>  40 	printf("___%d:%d call shmctl(%d,IPC_RMID,NULL)\n", __LINE__, getpid(), shmid);
>  41 	r = shmctl(shmid, IPC_RMID, NULL);
>  42 	printf("___%d:%d ret shmctl=%d, %s\n", __LINE__, getpid(), r, strerror(errno));
>  43 
>  44 	if ((pid_t)0 != pid) {
>  45 		printf("+++%d:%d call wait(NULL)\n", __LINE__, getpid());
>  46 		pid = wait(NULL);
>  47 		printf("+++%d:%d ret wait=%d\n", __LINE__, getpid(), (int)pid);
>  48 	}
>  49 
>  50 	return 0;
>  51 }
> The output of the test code is:
> ___19:11782 call shmget(325559,488,950)
> ___21:11782 ret shmget=2850820
> ___23:11782 call shmat(2850820,0,0)
> ___25:11782 ret shmat=0x7f452c223000
> +++27:11782 call fork
> +++29:11782 ret fork=11783
> ___31:11782 call shmctl(2850820,IPC_STAT,0x7fffdaf0a750)
> ___33:11782 ret shmctl=0
> ___34:11782 nattch=2
> ___36:11782 call shmdt(0x7f452c223000)
> +++29:11783 ret fork=0
> ___38:11782 ret shmdt=0
> ___40:11782 call shmctl(2850820,IPC_RMID,NULL)
> ___31:11783 call shmctl(2850820,IPC_STAT,0x7fffdaf0a750)
> ___42:11782 ret shmctl=0, Success
> +++45:11782 call wait(NULL)
> ___33:11783 ret shmctl=0
> ___34:11783 nattch=1
> ___36:11783 call shmdt(0x7f452c223000)
> ___38:11783 ret shmdt=0
> ___40:11783 call shmctl(2850820,IPC_RMID,NULL)
> ___42:11783 ret shmctl=-1, Invalid argument
> +++47:11782 ret wait=11783
> And sometimes output is:
> ___19:11798 call shmget(325559,488,950)
> ___21:11798 ret shmget=3112964
> ___23:11798 call shmat(3112964,0,0)
> ___25:11798 ret shmat=0x7f6b39378000
> +++27:11798 call fork
> +++29:11798 ret fork=11799
> ___31:11798 call shmctl(3112964,IPC_STAT,0x7fff3a6472a0)
> ___33:11798 ret shmctl=0
> +++29:11799 ret fork=0
> ___31:11799 call shmctl(3112964,IPC_STAT,0x7fff3a6472a0)
> ___34:11798 nattch=2
> ___36:11798 call shmdt(0x7f6b39378000)
> ___33:11799 ret shmctl=0
> ___38:11798 ret shmdt=0
> ___34:11799 nattch=2
> ___40:11798 call shmctl(3112964,IPC_RMID,NULL)
> ___36:11799 call shmdt(0x7f6b39378000)
> ___42:11798 ret shmctl=0, Success
> +++45:11798 call wait(NULL)
> ___38:11799 ret shmdt=0
> ___40:11799 call shmctl(3112964,IPC_RMID,NULL)
> ___42:11799 ret shmctl=-1, Invalid argument
> +++47:11798 ret wait=11799
>>From the outputs the parent process always get nattch=2, the child process
> get nattch=1 or sometimes get nattch=2.
> 
> Then please see the following lines of src/pcm/pcm_direct.c
> (from alsa-lib-1.1.0.tar.bz2):
>  110 	dmix->shmptr = shmat(dmix->shmid, 0, 0);
>  111 	if (dmix->shmptr == (void *) -1) {
>  112 		err = -errno;
>  113 		snd_pcm_direct_shm_discard(dmix);
>  114 		return err;
>  115 	}
>  116 	mlock(dmix->shmptr, sizeof(snd_pcm_direct_share_t));
>  117 	if (shmctl(dmix->shmid, IPC_STAT, &buf) < 0) {
>  118 		err = -errno;
>  119 		snd_pcm_direct_shm_discard(dmix);
>  120 		return err;
>  121 	}
>  122 	if (buf.shm_nattch == 1) {      /* we're the first user, clear the segment */
>  123 		memset(dmix->shmptr, 0, sizeof(snd_pcm_direct_share_t));
>  124 		if (dmix->ipc_gid>= 0) {
>  125 			buf.shm_perm.gid = dmix->ipc_gid;
>  126 			shmctl(dmix->shmid, IPC_SET, &buf);
>  127 		}
>  128 		dmix->shmptr->magic = SND_PCM_DIRECT_MAGIC;
>  129 		return 1;
>  130 	} else {
>  131 		if (dmix->shmptr->magic != SND_PCM_DIRECT_MAGIC) {
>  132 			snd_pcm_direct_shm_discard(dmix);
>  133 			return -EINVAL;
>  134 		}
>  135 	}
> If an applicatioin that uses alsa-lib invokes fork() and the fork() is invoked
> just after shmat(line 110) and just before shmctl(line 117), buf.shm_nattch
> will be 2, so "buf.shm_nattch == 1" will be false. But while buf.shm_nattch
> is 2, we're still the first user this time, and we should executes line 123 to
> line 129 of the codes above.
> 
> There is the following statement in `man shmget`:
>        When a new shared memory segment is created, its contents are initialized to zero values
> According to the statement above, dmix->shmptr->magic is 0 on shm first created.
> So, to fix this issue, we should change the following line:
>  122 	if (buf.shm_nattch == 1) {      /* we're the first user, clear the segment */
> to:
>  122 	if (dmix->shmptr->magic != SND_PCM_DIRECT_MAGIC) {      /* we're the first user, clear the segment */

You're talking about an application using threads ? Then a mutex should
be used here. Thanks for the analysis.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
