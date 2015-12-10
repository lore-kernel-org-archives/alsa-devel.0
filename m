From: IceBsi <bsiice@msn.com>
Subject: A root cause of "unable to create IPC shm instance"
Date: Thu, 10 Dec 2015 11:04:00 +0000
Message-ID: <COL125-W23C67B4D2A800D0EEC9E51D2E90@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from COL004-OMC3S17.hotmail.com (col004-omc3s17.hotmail.com
 [65.55.34.156]) by alsa0.perex.cz (Postfix) with ESMTP id 550CD26666F
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2015 12:04:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear ALSA developers:

I found a root cause of the following issue by using strace:
=A0 =A0 unable to create IPC shm instance

Firstly, please see the test code below:
=A0 1 #include <stdio.h>
=A0 2 #include <unistd.h>
=A0 3 #include <sys/ipc.h>
=A0 4 #include <sys/shm.h>
=A0 5 #include <errno.h>
=A0 6 #include <string.h>
=A0 7=A0
=A0 8 int main(int argc, char *argv[])
=A0 9 {
=A010 	int r =3D 0;
=A011 	struct shmid_ds buf;
=A012 	key_t ipc_key =3D (key_t)325559;
=A013 	size_t shmsize =3D 488;
=A014 	int shmid =3D -1;
=A015 	mode_t ipc_perm =3D 0666;
=A016 	void *shmptr =3D NULL;
=A017 	pid_t pid;
=A018=A0
=A019 	printf("___%d:%d call shmget(%d,%u,%d)\n", __LINE__, getpid(), (int)=
(ipc_key), shmsize, IPC_CREAT | ipc_perm);
=A020 	shmid =3D shmget(ipc_key, shmsize, IPC_CREAT | ipc_perm);
=A021 	printf("___%d:%d ret shmget=3D%d\n", __LINE__, getpid(), shmid);
=A022=A0
=A023 	printf("___%d:%d call shmat(%d,0,0)\n", __LINE__, getpid(), shmid);
=A024 	shmptr =3D shmat(shmid, 0, 0);
=A025 	printf("___%d:%d ret shmat=3D%p\n", __LINE__, getpid(), shmptr);
=A026=A0
=A027 	printf("+++%d:%d call fork\n", __LINE__, getpid());
=A028 	pid =3D fork();
=A029 	printf("+++%d:%d ret fork=3D%d\n", __LINE__, getpid(), (int)pid);
=A030=A0
=A031 	printf("___%d:%d call shmctl(%d,IPC_STAT,%p)\n", __LINE__, getpid(),=
 shmid, &buf);
=A032 	r =3D shmctl(shmid, IPC_STAT, &buf);
=A033 	printf("___%d:%d ret shmctl=3D%d\n", __LINE__, getpid(), r);
=A034 	printf("___%d:%d nattch=3D%lu\n", __LINE__, getpid(), buf.shm_nattch=
);
=A035=A0
=A036 	printf("___%d:%d call shmdt(%p)\n", __LINE__, getpid(), shmptr);
=A037 	r =3D shmdt(shmptr);
=A038 	printf("___%d:%d ret shmdt=3D%d\n", __LINE__, getpid(), r);
=A039=A0
=A040 	printf("___%d:%d call shmctl(%d,IPC_RMID,NULL)\n", __LINE__, getpid(=
), shmid);
=A041 	r =3D shmctl(shmid, IPC_RMID, NULL);
=A042 	printf("___%d:%d ret shmctl=3D%d, %s\n", __LINE__, getpid(), r, stre=
rror(errno));
=A043=A0
=A044 	if ((pid_t)0 !=3D pid) {
=A045 		printf("+++%d:%d call wait(NULL)\n", __LINE__, getpid());
=A046 		pid =3D wait(NULL);
=A047 		printf("+++%d:%d ret wait=3D%d\n", __LINE__, getpid(), (int)pid);
=A048 	}
=A049=A0
=A050 	return 0;
=A051 }
The output of the test code is:
___19:11782 call shmget(325559,488,950)
___21:11782 ret shmget=3D2850820
___23:11782 call shmat(2850820,0,0)
___25:11782 ret shmat=3D0x7f452c223000
+++27:11782 call fork
+++29:11782 ret fork=3D11783
___31:11782 call shmctl(2850820,IPC_STAT,0x7fffdaf0a750)
___33:11782 ret shmctl=3D0
___34:11782 nattch=3D2
___36:11782 call shmdt(0x7f452c223000)
+++29:11783 ret fork=3D0
___38:11782 ret shmdt=3D0
___40:11782 call shmctl(2850820,IPC_RMID,NULL)
___31:11783 call shmctl(2850820,IPC_STAT,0x7fffdaf0a750)
___42:11782 ret shmctl=3D0, Success
+++45:11782 call wait(NULL)
___33:11783 ret shmctl=3D0
___34:11783 nattch=3D1
___36:11783 call shmdt(0x7f452c223000)
___38:11783 ret shmdt=3D0
___40:11783 call shmctl(2850820,IPC_RMID,NULL)
___42:11783 ret shmctl=3D-1, Invalid argument
+++47:11782 ret wait=3D11783
And sometimes output is:
___19:11798 call shmget(325559,488,950)
___21:11798 ret shmget=3D3112964
___23:11798 call shmat(3112964,0,0)
___25:11798 ret shmat=3D0x7f6b39378000
+++27:11798 call fork
+++29:11798 ret fork=3D11799
___31:11798 call shmctl(3112964,IPC_STAT,0x7fff3a6472a0)
___33:11798 ret shmctl=3D0
+++29:11799 ret fork=3D0
___31:11799 call shmctl(3112964,IPC_STAT,0x7fff3a6472a0)
___34:11798 nattch=3D2
___36:11798 call shmdt(0x7f6b39378000)
___33:11799 ret shmctl=3D0
___38:11798 ret shmdt=3D0
___34:11799 nattch=3D2
___40:11798 call shmctl(3112964,IPC_RMID,NULL)
___36:11799 call shmdt(0x7f6b39378000)
___42:11798 ret shmctl=3D0, Success
+++45:11798 call wait(NULL)
___38:11799 ret shmdt=3D0
___40:11799 call shmctl(3112964,IPC_RMID,NULL)
___42:11799 ret shmctl=3D-1, Invalid argument
+++47:11798 ret wait=3D11799
>From the outputs the parent process always get nattch=3D2, the child process
get nattch=3D1 or sometimes get nattch=3D2.

Then please see the following lines of src/pcm/pcm_direct.c
(from alsa-lib-1.1.0.tar.bz2):
=A0110 	dmix->shmptr =3D shmat(dmix->shmid, 0, 0);
=A0111 	if (dmix->shmptr =3D=3D (void *) -1) {
=A0112 		err =3D -errno;
=A0113 		snd_pcm_direct_shm_discard(dmix);
=A0114 		return err;
=A0115 	}
=A0116 	mlock(dmix->shmptr, sizeof(snd_pcm_direct_share_t));
=A0117 	if (shmctl(dmix->shmid, IPC_STAT, &buf) < 0) {
=A0118 		err =3D -errno;
=A0119 		snd_pcm_direct_shm_discard(dmix);
=A0120 		return err;
=A0121 	}
=A0122 	if (buf.shm_nattch =3D=3D 1) { =A0 =A0 =A0/* we're the first user, =
clear the segment */
=A0123 		memset(dmix->shmptr, 0, sizeof(snd_pcm_direct_share_t));
=A0124 		if (dmix->ipc_gid>=3D 0) {
=A0125 			buf.shm_perm.gid =3D dmix->ipc_gid;
=A0126 			shmctl(dmix->shmid, IPC_SET, &buf);
=A0127 		}
=A0128 		dmix->shmptr->magic =3D SND_PCM_DIRECT_MAGIC;
=A0129 		return 1;
=A0130 	} else {
=A0131 		if (dmix->shmptr->magic !=3D SND_PCM_DIRECT_MAGIC) {
=A0132 			snd_pcm_direct_shm_discard(dmix);
=A0133 			return -EINVAL;
=A0134 		}
=A0135 	}
If an applicatioin that uses alsa-lib invokes fork() and the fork() is invo=
ked
just after shmat(line 110) and just before shmctl(line 117), buf.shm_nattch
will be 2, so "buf.shm_nattch =3D=3D 1" will be false. But while buf.shm_na=
ttch
is 2, we're still the first user this time, and we should executes line 123=
 to
line 129 of the codes above.

There is the following statement in `man shmget`:
=A0 =A0 =A0 =A0When a new shared memory segment is created, its contents ar=
e initialized to zero values
According to the statement above, dmix->shmptr->magic is 0 on shm first cre=
ated.
So, to fix this issue, we should change the following line:
=A0122 	if (buf.shm_nattch =3D=3D 1) { =A0 =A0 =A0/* we're the first user, =
clear the segment */
to:
=A0122 	if (dmix->shmptr->magic !=3D SND_PCM_DIRECT_MAGIC) { =A0 =A0 =A0/* =
we're the first user, clear the segment */

Sincerely,
Sisrnb

 		 	   		  =
